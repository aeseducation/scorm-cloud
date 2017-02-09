module ScormCloud
  class CourseService < BaseService
    not_implemented :properties, :get_assets, :update_assets, :get_file_structure, :delete_files

    # See http://cloud.scorm.com/doc/web-services/api.html#rustici.course.getAsyncImportResult
    #
    # The XML for error responses looks like this:
    #
    #   <?xml version='1.0' encoding='UTF-8'?>
    #   <rsp stat='ok'>
    #     <status>error</status>
    #     <error code='2'><![CDATA[Course zip file not found]]></error>
    #   </rsp>
    def get_async_import_result(token)
      xml = connection.call("rustici.course.getAsyncImportResult", :token => token)

      status = xml.elements["//rsp/status"].text.downcase
      response = { :status => status }

      case status
      when "error"
        response.merge!({
          :error_code => xml.elements["//rsp/error"].attributes["code"],
          :error_msg => xml.elements["//rsp/error"].text,
        })
      when "finished"
        response.merge!(process_importresult(xml))
      end

      response
    end

    # See http://cloud.scorm.com/doc/web-services/api.html#rustici.course.importCourseAsync
    def import_course_async(course_id, file)
      if file.respond_to? :read
        xml = connection.post("rustici.course.importCourseAsync", file, :courseid => course_id)
      else
        xml = connection.call("rustici.course.importCourseAsync", :courseid => course_id, :path => file)
      end

      if xml.elements['//rsp/token/id']
        token = xml.elements['//rsp/token/id'].text
        { :token => token }
      else
        # The API docs aren't at all clear what happens if this call fails and
        # I haven't found a way to trigger an error. So for now, nil will have to suffice.
        nil
      end
    end

    # TODO: Handle Warnings
    def import_course(course_id, file)
      if file.respond_to? :read
        xml = connection.post("rustici.course.importCourse", file, :courseid => course_id)
      else
        xml = connection.call("rustici.course.importCourse", :courseid => course_id, :path => file)
      end

      process_importresult(xml)
    end

    def exists(course_id)
      connection.call_raw("rustici.course.exists", :courseid => course_id).include?("<result>true</result>")
    end

    def get_attributes(course_id)
      xml = connection.call("rustici.course.getAttributes", :courseid => course_id)
      xml_to_attributes(xml)
    end

    def delete_course(course_id)
      connection.call("rustici.course.deleteCourse", :courseid => course_id)
      true
    end

    def get_manifest(course_id)
      connection.call_raw("rustici.course.getManifest", :courseid => course_id)
    end

    def get_course_list(options = {})
      xml = connection.call("rustici.course.getCourseList", options)
      xml.elements["/rsp/courselist"].map { |e| Course.from_xml(e) }
    end

    def preview(course_id, redirect_url)
      connection.launch_url("rustici.course.preview", :courseid => course_id, :redirecturl => redirect_url)
    end

    def update_attributes(course_id, attributes)
      xml = connection.call("rustici.course.updateAttributes", attributes.merge({:courseid => course_id}))
      xml_to_attributes(xml)
    end

    def get_metadata(course_id, scope='course')
      xml = connection.call("rustici.course.getMetadata", courseid: course_id, scope: scope)
      xml.elements['/rsp/package']
    end

    private

    def process_importresult(xml)
      if xml.elements['//rsp//importresult'] && xml.elements['//rsp//importresult'].attributes["successful"] == "true"
        title = xml.elements['//rsp//importresult/title'].text 
        { :title => title, :warnings => [] }
      else
        # Package wasn't a zip file at all
        invalid = xml.elements['//rsp//importresult'].nil?
        # Package was a zip file that wasn't a SCORM package
        invalid ||= xml.elements['//rsp//importresult/message'] && xml.elements['//rsp//importresult/message'].text == 'zip file contained no courses'

        if invalid
          raise InvalidPackageError
        else
          xml_text = ''
          xml.write(xml_text)
          raise "Not successful. Response: #{xml_text}"
        end
      end
    end
  end
end

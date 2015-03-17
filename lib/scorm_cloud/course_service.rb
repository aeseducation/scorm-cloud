module ScormCloud
  class CourseService < BaseService
    not_implemented :import_cours_async, :get_async_import_result,
      :properties, :get_assets, :update_assets,
      :get_file_structure, :delete_files

    # TODO: Handle Warnings
    def import_course(course_id, file)
      if file.respond_to? :read
        xml = connection.post("rustici.course.importCourse", file, :courseid => course_id)
      else
        xml = connection.call("rustici.course.importCourse", :courseid => course_id, :path => file)
      end

      unless xml.elements['//rsp/importresult']
        xml_text = ''
        xml.write(xml_text)
        raise "Missing importresult element. Entire response: #{xml_text}"
      end

      if xml.elements['//rsp/importresult'].attributes["successful"] == "true"
        title = xml.elements['//rsp/importresult/title'].text 
        { :title => title, :warnings => [] }
      else
        # Package wasn't a zip file at all
        invalid = xml.elements['//rsp/importresult'].nil?
        # Package was a zip file that wasn't a SCORM package
        invalid ||= xml.elements['//rsp/importresult/message'] && xml.elements['//rsp/importresult/message'].text == 'zip file contained no courses'

        if invalid
          raise InvalidPackageError
        else
          xml_text = ''
          xml.write(xml_text)
          raise "Not successful. Response: #{xml_text}"
        end
      end
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
  end
end

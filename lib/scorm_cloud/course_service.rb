module ScormCloud
	class CourseService < BaseService

		not_implemented :import_cours_async, :get_async_import_result,
				:properties, :get_assets, :update_assets,
				:get_file_structure, :delete_files, :get_metadata

		# TODO: Handle Warnings
		def import_course(course_id, path)
			xml = connection.call("rustici.course.importCourse", :courseid => course_id, :path => path)
			if xml.elements['//rsp/importresult'].attributes["successful"] == "true"
				title = xml.elements['//rsp/importresult/title'].text	
				{ :title => title, :warnngs => [] }
			else
				nil
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

		def preview(course_id)
			connection.call_raw("rustici.course.preview", :courseid => course_id)
		end

		def update_attributes(course_id, attributes)
			xml = connection.call("rustici.course.updateAttributes", attributes.merge({:courseid => course_id}))
			xml_to_attributes(xml)
		end

	end
end


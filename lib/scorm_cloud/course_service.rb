module ScormCloud
	class CourseService < BaseService

		not_implemented :import_cours_async, :get_async_import_result,
				:exists, :get_assets, :update_assets, :delete_course,
				:get_file_structure, :delete_files, :get_attributes, :update_attributes,
				:get_metadata, :get_manifest, :get_course_list

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

		def preview(course_id)
			connection.call_raw("rustici.course.preview", :courseid => course_id)
		end

		def properties(course_id)
			connection.call_raw("rustici.course.properties", :courseid => course_id)
		end

				
		# def get_manifest(course_id)
		# 	connection.call_raw("rustici.course.getManifest", :courseid => course_id)
		# end

		def get_course_list(options = {})
			xml = connection.call("rustici.course.getCourseList", options)
			xml.elements["/rsp/courselist"].map { |e| Course.from_xml(e) }
		end

		def delete_course(course_id)
			connection.call("rustici.course.deleteCourse", :courseid => course_id)
			true
		end

	end
end


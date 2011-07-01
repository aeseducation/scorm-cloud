require 'scorm_cloud/course'

module ScormCloud
	class CourseService < ScormCloud::Base

		not_implemented :import_course, :import_cours_async, :get_async_import_result,
				:preview, :properties, :exists, :get_assets, :update_assets, :delete_course,
				:get_file_structure, :delete_files, :get_attributes, :update_attributes,
				:get_metadata, :get_manifest

		def get_course_list(connection, filter=nil, tags=nil)
			raise "Filter Not Implemented" if filter
			raise "Tags Not Implemented" if tags
			xml = connection.call("rustici.course.getCourseList")
			xml.elements["/rsp/courselist"].map { |element| ScormCloud::Course.new(element.attributes) }
		end

	end
end


require 'scorm_cloud/course'

module ScormCloud
	class CourseService

		def import_course
			raise "Not Implemented"
		end

		def import_cours_async
			raise "Not Implemented"
		end

		def get_async_import_result
			raise "Not Implemented"
		end

		def preview
			raise "Not Implemented"
		end

		def properties
			raise "Not Implemented"
		end

		def exists
			raise "Not Implemented"
		end

		def get_assets
			raise "Not Implemented"
		end

		def update_assets
			raise "Not Implemented"
		end

		def delete_course
			raise "Not Implemented"
		end

		def get_file_structure
			raise "Not Implemented"
		end

		def delete_files
			raise "Not Implemented"
		end

		def get_attributes
			raise "Not Implemented"
		end

		def update_attributes
			raise "Not Implemented"
		end

		def get_metadata
			raise "Not Implemented"
		end

		def get_manifest
			raise "Not Implemented"
		end

		def get_course_list(connection, filter=nil, tags=nil)
			raise "Filter Not Implemented" if filter
			raise "Tags Not Implemented" if tags
			xml = connection.call("rustici.course.getCourseList")
			xml.elements["/rsp/courselist"].map { |element| ScormCloud::Course.new(element.attributes) }
		end

	end
end


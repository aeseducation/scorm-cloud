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

		def get_manifest(connection, course_id)
			connection.call_raw("rustici.course.getManifest", :courseid => course_id)
		end

		def get_course_list(connection, options = {})
			xml = connection.call("rustici.course.getCourseList", options)
			xml.elements["/rsp/courselist"].map { |element| 
				ScormCloud::Course.new(element.attributes) 
			}
		end

	end
end


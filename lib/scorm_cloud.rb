require 'rexml/document'
require 'digest/md5'
require 'net/http'
require 'uri'

require 'scorm_cloud/base'
require 'scorm_cloud/connection'
require 'scorm_cloud/debug_service'
require 'scorm_cloud/upload_service'
require 'scorm_cloud/course_service'
require 'scorm_cloud/registration_service'
require 'scorm_cloud/tagging_service'
require 'scorm_cloud/reporting_service'
require 'scorm_cloud/dispatch_service'
require 'scorm_cloud/export_service'

module ScormCloud

	def self.connect(appid, secret)
		@connection ||= Connection.new(appid, secret)
	end

	def self.debug; 			@debug  	  ||= DebugService.new;				end
	def self.upload;			@upload 	  ||= UploadService.new;			end
	def self.course;			@course 	  ||= CourseService.new;			end
	def self.registration;		@registration ||= RegistrationService.new;		end
	def self.tagging;			@tagging      ||= TaggingService.new;			end
	def self.reporting;			@reporting    ||= ReportingService.new;			end
	def self.dispatch;			@dispatch     ||= DispatchService.new;			end
	def self.export;			@export       ||= ExportService.new;			end

end
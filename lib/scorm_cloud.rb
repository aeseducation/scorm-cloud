require 'rexml/document'
require 'digest/md5'
require 'net/http'
require 'net/http/post/multipart'
require 'uri'
require 'scorm_cloud/base'

require 'scorm_cloud/base_object'
require 'scorm_cloud/course'
require 'scorm_cloud/registration'
require 'scorm_cloud/registration_result'

require 'scorm_cloud/base_service'
require 'scorm_cloud/debug_service'
require 'scorm_cloud/upload_service'
require 'scorm_cloud/course_service'
require 'scorm_cloud/registration_service'
require 'scorm_cloud/tagging_service'
require 'scorm_cloud/reporting_service'
require 'scorm_cloud/dispatch_service'
require 'scorm_cloud/export_service'

# Rails 3 Integration
require 'scorm_cloud/railtie' if defined?(Rails::Railtie)

module ScormCloud
	class ScormCloud < Base
		add_service :debug => DebugService
		add_service :upload => UploadService
		add_service :course => CourseService
		add_service :registration => RegistrationService
		add_service :tagging => TaggingService
		add_service :reporting => ReportingService
		add_service :dispatch => DispatchService
		add_service :export => ExportService
	end
end

module ScormCloud
  module ScormRailsHelpers

  	def scorm_cloud
  		unless @scorm_cloud
  			@scorm_cloud = ::ScormCloud::ScormCloud.new(
              Rails.configuration.scorm_appid,
              Rails.configuration.scorm_secretkey
            )
  		end
  		@scorm_cloud
  	end

  end
end

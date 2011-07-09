module ScormCloud
  module ScormRailsHelpers

  	def scorm_cloud
  		unless @scorm_cloud
  			@scorm_cloud = ::ScormCloud::ScormCloud.new(
          ::Rails.configuration.scorm_cloud.appid, 
          ::Rails.configuration.scorm_cloud.secretkey
        )
  		end
  		@scorm_cloud
  	end

  end
end

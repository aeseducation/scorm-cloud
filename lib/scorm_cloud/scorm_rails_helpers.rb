module ScormCloud
  module ScormRailsHelpers

  	def scorm_cloud
  		unless @scorm_cloud

        puts "-------------"
        puts Rails.configuration.inspect
        puts Rails.configuration.config.inspect

  			@scorm_cloud = ::ScormCloud::ScormCloud.new(
              Rails.configuration.config.scorm_appid,
              Rails.configuration.config.scorm_secretkey
            )
  		end
  		@scorm_cloud
  	end

  end
end

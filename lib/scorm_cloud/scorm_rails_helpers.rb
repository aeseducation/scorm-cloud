module ScormCloud
  module ScormRailsHelpers

  	def self.apikey=(apikey)
  		@scorm_apiky = value
  	end

  	def self.secret=(secret)
  		@scorm_secret = value
  	end

  	def scorm_cloud
  		unless @scorm_cloud
  			@scorm_cloud = ScormCloud::ScormCloud.new(@scorm_apikey, @scorm_secret)
  		end
  		@scorm_cloud
  	end

  end
end

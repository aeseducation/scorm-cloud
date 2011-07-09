module ScormCloud
  module ScormRailsHelpers

  	def self.appid=(appid)
  		@scorm_appid = appid
  	end

  	def self.secretkey=(secretkey)
  		@scorm_secretkey = secretkey
  	end

  	def scorm_cloud
  		unless @scorm_cloud
  			@scorm_cloud = ScormCloud::ScormCloud.new(@scorm_appid, @scorm_secretkey)
  		end
  		@scorm_cloud
  	end

  end
end

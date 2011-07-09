module ScormCloud
  module ScormRailsHelpers

  	def self.scorm_appid=(appid)
  		@scorm_appid = appid
  	end

    def self.scorm_appid
      @scorm_appid
    end

  	def self.scorm_secretkey=(secretkey)
  		@scorm_secretkey = secretkey
  	end

    def self.scorm_secretkey
      @scorm_secretkey
    end

  	def scorm_cloud
  		unless @scorm_cloud
  			@scorm_cloud = ::ScormCloud::ScormCloud.new(self.scorm_appid, self.scorm_secretkey)
  		end
  		@scorm_cloud
  	end

  end
end

module ScormCloud
	class RegistrationResult < ScormCloud::BaseObject

		attr_accessor :format, :regid, :instanceid, :complate, :success, 
									:totaltime, :score


		def self.from_xml(element)
			reg_result = RegistrationResult.new
			reg_result.format = "course"
			reg_result.regid = element.elements["rsp"].elements["registrationreport"].attributes["regid"]
			reg_result.instanceid = element.elements["rsp"].elements["registrationreport"].attributes["instanceid"]
			reg_result.complate = element.elements["rsp"].elements["registrationreport"][0].text
			reg_result.success = element.elements["rsp"].elements["registrationreport"][1].text
			reg_result.totaltime = element.elements["rsp"].elements["registrationreport"][2].text
			reg_result.score = element.elements["rsp"].elements["registrationreport"][3].text		
			reg_result
		end

	end
end
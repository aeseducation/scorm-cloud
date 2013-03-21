module ScormCloud
	class RegistrationResult < ScormCloud::BaseObject

		attr_accessor :format, :regid, :instanceid, :complate, :success, 
									:totaltime, :score


		def self.from_xml(element)
			reg_result = RegistrationResult.new
			reg_result.set_attributes(element.attributes)
			element.children.each do |element|
				reg_result.set_attr(element.name, element.text)
			end
			reg_result
		end

	end
end
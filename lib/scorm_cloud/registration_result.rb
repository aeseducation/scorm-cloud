module ScormCloud
	class RegistrationResult < ScormCloud::BaseObject

    attr_accessor :complete, :success, :totaltime, :score, :format, :instanceid, :regid

		def self.from_xml(element)
			r = RegistrationResult.new
      r.set_attributes(element.attributes)
      element.children.each do |element|
        r.set_attr(element.name, element.text)
      end
			r
		end

	end
end

module ScormCloud
	class Course < ScormCloud::BaseObject

		attr_accessor :id, :versions, :registrations, :title, :size

		def self.from_xml(element)
			c = Course.new
			c.set_attributes(element.attributes)
			c
		end

	end
end
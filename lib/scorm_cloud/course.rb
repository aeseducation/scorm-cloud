module ScormCloud
	class Course

		attr_accessor :id, :size, :versions, :registrations, :title

		def initialize(attributes = {})
			attributes.each { |k,v| send("#{k}=".to_sym, v) }
		end

	end
end
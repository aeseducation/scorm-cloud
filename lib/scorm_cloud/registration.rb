module ScormCloud
	class Registration < ScormCloud::BaseObject

		attr_accessor :id, :courseid, :app_id, :registration_id, :course_id,
				:course_title, :learner_id, :learner_first_name, :learner_last_name,
				:email, :create_date, :first_access_date, :last_access_date,
				:completed_date, :instances, :last_course_version_launched

		def self.from_xml(element)
			r = Registration.new
			r.set_attributes(element.attributes)
			element.children.each do |element|
				r.set_attr(element.name, element.text)
			end
			r
		end

	end
end
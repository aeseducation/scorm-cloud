module ScormCloud
	class TaggingService < BaseService
		not_implemented :get_course_tags, :set_course_tags, :add_course_tag,
				:remove_course_tag, :get_learner_tags, :set_learner_tags, :add_learner_tag,
				:remove_learner_tag, :get_registration_tags, :set_registration_tags,
				:add_registration_tag, :remove_registration_tag
	end
end


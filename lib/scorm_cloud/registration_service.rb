module ScormCloud
	class RegistrationService < ScormCloud::Base

		not_implemented :create_registration, :delete_registration, :reset_registration,
			:get_registration_list, :get_registration_result, :get_registration_list_results,
			:launch, :get_launch_history, :get_launch_info, :reset_global_objectives,
			:update_learner_info, :test_registration_post_url

	end
end

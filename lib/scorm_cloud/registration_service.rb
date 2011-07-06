module ScormCloud
	class RegistrationService < BaseService

		not_implemented :create_registration, :delete_registration, :reset_registration,
			:get_registration_result, :get_registration_list_results,
			:launch, :get_launch_history, :get_launch_info, :reset_global_objectives,
			:update_learner_info, :test_registration_post_url

		def get_registration_list(options = {})
			xml = connection.call("rustici.registration.getRegistrationList", options)
			xml.elements["/rsp/registrationlist"].map { |e| Registration.from_xml(e) }
		end

	end
end

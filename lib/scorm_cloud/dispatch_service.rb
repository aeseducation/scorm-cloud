module ScormCloud
	class DispatchService < BaseService

		not_implemented :get_destination_list, :get_destination_info, :create_destination,
				:update_destination, :delete_destination, :get_dispatch_list, :get_dispatch_info,
				:create_dispatch, :update_dispatches, :download_dispatches, :delete_dispatches
			
	end
end
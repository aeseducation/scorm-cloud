module ScormCloud
	class UploadService < BaseService

		not_implemented :get_upload_token, :upload_file, :get_upload_progress,
				:list_files, :delete_files

	end
end

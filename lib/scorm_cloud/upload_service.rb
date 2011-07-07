module ScormCloud
	class UploadService < BaseService

		not_implemented :get_upload_progress

		def get_upload_token
			xml = connection.call("rustici.upload.getUploadToken")
			xml.elements["/rsp/token/id"].text
		end

		def upload_file(token, path)
			xml = connection.post("rustici.upload.uploadFile", path, :token => token)
			xml.elements["/rsp/location"].text
		end

		def list_files
			xml = connection.call("rustici.upload.listFiles")
			xml.elements["//rsp/dir"].map do |f|
				{
					:dir => f.parent.attributes["name"],
					:file => f.attributes["name"], 
					:modified => f.attributes["modified"],
					:size => f.attributes["modified"].to_i
				}
			end
		end

		def delete_files files
			if !files.is_a?(String) && files.is_a?(Enumerable)
			 	files = files.map { |f| "file=#{f}"}.join('&')
			end
			result = connection.call("rustici.upload.deleteFiles", { :file => files })
			!result.to_s.include?("deleted='false'")
		end

	end
end

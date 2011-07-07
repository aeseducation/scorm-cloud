require 'spec_helper'

describe "Rustici Web Service API" do

	describe ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret).upload do

		# interface
		it { should respond_to(:get_upload_token) }
		it { should respond_to(:upload_file) }
		it { should respond_to(:get_upload_progress) }
		it { should respond_to(:list_files) }
		it { should respond_to(:delete_files) }

	end

end

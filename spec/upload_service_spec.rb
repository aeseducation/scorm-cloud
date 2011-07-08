require 'spec_helper'

describe "Rustici Web Service API" do

	describe ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret).upload do

		# interface
		it { should respond_to(:get_upload_token).with(0).arguments }
		it { should respond_to(:upload_file).with(2).arguments }
		it { should respond_to(:list_files).with(0).arguments }
		it { should respond_to(:delete_files).with(1).arguments }

		# not implemented
		it { should respond_to(:get_upload_progress).with(0).arguments }

	end

end

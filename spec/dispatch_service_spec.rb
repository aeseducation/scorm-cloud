require 'spec_helper'

describe "Rustici Web Service API" do

	describe ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret).dispatch do

		it { should respond_to(:get_destination_list) }
		it { should respond_to(:get_destination_info) }
		it { should respond_to(:create_destination) }
		it { should respond_to(:update_destination) }
		it { should respond_to(:delete_destination) }
		it { should respond_to(:get_dispatch_list) }
		it { should respond_to(:get_dispatch_info) }
		it { should respond_to(:create_dispatch) }
		it { should respond_to(:update_dispatches) }
		it { should respond_to(:download_dispatches) }
		it { should respond_to(:delete_dispatches) }
			
	end

end
require 'spec_helper'

describe "Rustici Web Service API" do

	describe ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret).registration do

		# interface
		it { should respond_to(:create_registration).with(5).arguments }
		it { should respond_to(:create_registration).with(6).arguments }
		it { should respond_to(:get_registration_list).with(0).arguments }
		it { should respond_to(:get_registration_list).with(1).arguments }
		it { should respond_to(:delete_registration).with(1).arguments }
		it { should respond_to(:reset_registration).with(1).arguments }
		it { should respond_to(:get_registration_result).with(1).arguments }
		it { should respond_to(:get_registration_result).with(2).arguments }
		it { should respond_to(:launch).with(2).arguments }
		it { should respond_to(:launch).with(3).arguments }

		# not implemented
		it { should respond_to(:get_registration_list_results)}
		it { should respond_to(:get_launch_history) }
		it { should respond_to(:get_launch_info) }
		it { should respond_to(:reset_global_objectives) }
		it { should respond_to(:update_learner_info) }
		it { should respond_to(:test_registration_post_url) }
		
	end
end

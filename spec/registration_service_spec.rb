require 'spec_helper'

describe "Rustici Web Service API" do

	describe ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret).registration do

		it { should respond_to(:create_registration) }
		it { should respond_to(:delete_registration) }
		it { should respond_to(:reset_registration) }
		it { should respond_to(:get_registration_result) }
		it { should respond_to(:get_registration_list_results)}
		it { should respond_to(:launch) }
		it { should respond_to(:get_launch_history) }
		it { should respond_to(:get_launch_info) }
		it { should respond_to(:reset_global_objectives) }
		it { should respond_to(:update_learner_info) }
		it { should respond_to(:test_registration_post_url) }
		it { should respond_to(:get_registration_list).with(0).arguments }

		# it "should get registration lists" do
		# 	registrations = subject.get_registration_list
		# 	registrations.length.should_not eq(0)
		# 	registrations.each do |r|
		# 		r.id.should_not be_nil
		# 	end
		# end

	end
end

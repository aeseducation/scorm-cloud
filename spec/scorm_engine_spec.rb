require 'spec_helper'

describe "The scorm cloud module" do

	describe ScormCloud.debug do

		before(:each) do
			@c = ScormCloud.connect($scorm_cloud_appid,$scorm_cloud_secret)
		end

		it "should support rustici.debug.ping" do
			ScormCloud.debug.ping(@c).should eq("pong")
		end

		it "should support rustici.debug.authPing" do
			ScormCloud.debug.auth_ping(@c).should eq("pong")
		end

		it "should support rustici.debug.getTime" do
			ScormCloud.debug.get_time(@c).should match(/\d+/)
		end

	end

	describe ScormCloud.upload do
		it { should respond_to(:get_upload_token) }
		it { should respond_to(:upload_file) }
		it { should respond_to(:get_upload_progress) }
		it { should respond_to(:list_files) }
		it { should respond_to(:delete_files) }
	end

	describe ScormCloud.course do
		it { should respond_to(:import_course) }
		it { should respond_to(:import_cours_async) }
		it { should respond_to(:get_async_import_result) }
		it { should respond_to(:preview) }
		it { should respond_to(:properties) }
		it { should respond_to(:exists) }
		it { should respond_to(:get_assets) }
		it { should respond_to(:update_assets) }
		it { should respond_to(:delete_course) }
		it { should respond_to(:get_file_structure) }
		it { should respond_to(:delete_files) }
		it { should respond_to(:get_attributes) }
		it { should respond_to(:update_attributes) }
		it { should respond_to(:get_metadata) }
		it { should respond_to(:get_manifest) }
		it { should respond_to(:get_course_list) }
	end

	describe ScormCloud.registration do
		it { should respond_to(:create_registration) }
		it { should respond_to(:delete_registration) }
		it { should respond_to(:reset_registration) }
		it { should respond_to(:get_registration_list) }
		it { should respond_to(:get_registration_result) }
		it { should respond_to(:get_registration_list_results)}
		it { should respond_to(:launch) }
		it { should respond_to(:get_launch_history) }
		it { should respond_to(:get_launch_info) }
		it { should respond_to(:reset_global_objectives) }
		it { should respond_to(:update_learner_info) }
		it { should respond_to(:test_registration_post_url) }
	end

	describe ScormCloud.tagging do
		it { should respond_to(:get_course_tags) }
		it { should respond_to(:set_course_tags) }
		it { should respond_to(:add_course_tag) }
		it { should respond_to(:remove_course_tag) }
		it { should respond_to(:get_learner_tags) }
		it { should respond_to(:set_learner_tags) }
		it { should respond_to(:add_learner_tag) }
		it { should respond_to(:remove_learner_tag) }
		it { should respond_to(:get_registration_tags) }
		it { should respond_to(:set_registration_tags) }
		it { should respond_to(:add_registration_tag) }
		it { should respond_to(:remove_registration_tag) }
	end

	describe ScormCloud.reporting do
		it { should respond_to(:get_account_info) }
		it { should respond_to(:get_reportage_auth) }
		it { should respond_to(:launch_report) }
	end

	describe ScormCloud.dispatch do
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

	describe ScormCloud.export do
		it { should respond_to(:start) }
		it { should respond_to(:cancel) }
		it { should respond_to(:status) }
		it { should respond_to(:download) }
		it { should respond_to(:list) }
	end
		
	
end

require 'spec_helper'

describe "Rustici Web Service API" do

	describe ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret).course do

		it { should respond_to(:import_course).with(2).arguments }
		it { should respond_to(:import_cours_async) }
		it { should respond_to(:get_async_import_result) }
		it { should respond_to(:preview) }
		it { should respond_to(:properties) }
		it { should respond_to(:exists) }
		it { should respond_to(:get_assets) }
		it { should respond_to(:update_assets) }
		it { should respond_to(:delete_course).with(1).arguments }
		it { should respond_to(:get_file_structure) }
		it { should respond_to(:delete_files) }
		it { should respond_to(:get_attributes) }
		it { should respond_to(:update_attributes) }
		it { should respond_to(:get_metadata) }
		it { should respond_to(:get_metadata) }
		it { should respond_to(:get_metadata) }
		it { should respond_to(:get_manifest) }
 		it { should respond_to(:get_course_list).with(0).argument }
 		it { should respond_to(:get_course_list).with(1).argument }

	end

end

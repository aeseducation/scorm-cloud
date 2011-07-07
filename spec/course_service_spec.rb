require 'spec_helper'

describe "Rustici Web Service API" do

	describe ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret).course do

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
		it { should respond_to(:get_metadata).with(1).argument }
		it { should respond_to(:get_metadata).with(2).arguments }
		it { should respond_to(:get_manifest).with(1).arguments }
 		it { should respond_to(:get_course_list).with(0).argument }
 		it { should respond_to(:get_course_list).with(1).argument }

		# it "should return a manifest as text" do
		# 	manifest = subject.get_manifest('ZZHSANTMYCO02')
		# 	manifest.should include('<manifest')
		# end

		# it "should get course lists" do
		# 	courses = subject.get_course_list
		# 	courses.length.should_not eq(0)
		# 	courses.each do |c|
		# 		c.title.should_not be_nil
		# 		c.id.should_not be_nil
		# 	end
		# end

	end

end

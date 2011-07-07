require 'spec_helper'

describe "Rustici Web Service API" do

	describe ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret).export do
		it { should respond_to(:start) }
		it { should respond_to(:cancel) }
		it { should respond_to(:status) }
		it { should respond_to(:download) }
		it { should respond_to(:list) }
	end

end
require 'spec_helper'

describe "Rustici Web Service API" do
  describe ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret).course do
    it { should respond_to(:import_course).with(2).arguments }
    it { should respond_to(:preview).with(2).argument }
    it { should respond_to(:delete_course).with(1).arguments }
    it { should respond_to(:exists).with(1).argument }
    it { should respond_to(:get_attributes).with(1).argument }
    it { should respond_to(:update_attributes).with(2).arguments }
    it { should respond_to(:get_manifest).with(1).argument }
    it { should respond_to(:get_course_list).with(0).argument }
    it { should respond_to(:get_course_list).with(1).argument }

    # Not Implemented
    it { should respond_to(:get_assets).with(0).arguments }
    it { should respond_to(:update_assets).with(0).arguments }
    it { should respond_to(:import_cours_async).with(0).arguments }
    it { should respond_to(:get_async_import_result).with(0).arguments }
    it { should respond_to(:properties).with(0).arguments }
    it { should respond_to(:get_file_structure).with(0).arguments }
    it { should respond_to(:delete_files).with(0).arguments }
    it { should respond_to(:get_metadata).with(0).arguments }
  end
end

require 'spec_helper'

describe ScormCloud do
  let (:override_url) { 'http://localhost/api' }
  let (:default_url) { 'http://cloud.scorm.com/api' }
  describe "#initialize" do
    it "should allow api url override" do
      sc = ScormCloud::ScormCloud.new('app_id','app_secret', override_url)
      sc.api_url.should eq override_url
    end

    it "should default to http://cloud.scorm.com/api" do
      sc = ScormCloud::ScormCloud.new('app_id','app_secret')
      sc.api_url.should eq default_url
    end
  end

  describe "#prepare_url" do
    it "should contain the api url override" do
      # have to use launch_url as it returns the resulting call to
      # prepare_url. The scope of prepare_url is private thus preventing
      # us from calling it directly
      sc = ScormCloud::ScormCloud.new('app_id','app_secret', override_url)
      sc.launch_url('test').include?(override_url).should be_true
    end
  end
end

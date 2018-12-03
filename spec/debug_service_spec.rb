require 'spec_helper'

describe "Rustici Web Service API" do
  describe ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret).debug do
    # interface
    it { should respond_to(:ping).with(0).arguments }
    it { should respond_to(:auth_ping).with(0).arguments }
    it { should respond_to(:get_time).with(0).arguments }

    it "should ping the server" do
      expect(subject.ping).to include("pong")
    end

    it "should auth_ping the server" do
      expect(subject.auth_ping).to include("pong")
    end

    it "should get the time" do
      expect(subject.get_time).to match(/\d+/)
    end
  end
end

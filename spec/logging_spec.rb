require 'spec_helper'

describe "Logging" do
  describe ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret) do
    it "should not log by default" do
      logger = double("logger", 'nil?' => true) # odd, but necessary to test expectations
      subject.logger = logger
      expect(subject).to receive(:log_request_response).and_call_original
      expect(logger).not_to receive(:debug)
      subject.debug.ping
    end

    it "should log if configured to do so" do
      logger = double("logger")
      subject.logger = logger
      expect(subject).to receive(:log_request_response).and_call_original
      expect(logger).to receive(:debug).twice
      subject.debug.ping
    end
  end
end

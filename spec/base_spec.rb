require "spec_helper"

describe "Rustici Web Service API" do
  describe ScormCloud::ScormCloud do
    describe "api_url" do
      it "defaults to https://cloud.scorm.com/api" do
        expect(described_class.new("appid", "secret").api_url).to eq "https://cloud.scorm.com/api"
      end

      it "falls back to https://cloud.scorm.com/api" do
        expect(described_class.new("appid", "secret", nil).api_url).to eq "https://cloud.scorm.com/api"
      end

      it "can be overridden" do
        expect(described_class.new("appid", "secret", "apiurl").api_url).to eq "apiurl"
      end
    end
  end
end

require 'spec_helper'

describe "Rustici Web Service API" do
  describe ScormCloud::ScormCloud.new($scorm_cloud_appid,$scorm_cloud_secret).tagging do
    it { should respond_to(:get_course_tags).with(1).arguments }
    it { should respond_to(:set_course_tags).with(2).arguments }
    it { should respond_to(:add_course_tag).with(2).arguments }
    it { should respond_to(:remove_course_tag).with(2).arguments }
    it { should respond_to(:get_learner_tags).with(1).arguments }
    it { should respond_to(:set_learner_tags).with(2).arguments }
    it { should respond_to(:add_learner_tag).with(2).arguments }
    it { should respond_to(:remove_learner_tag).with(2).arguments }
    it { should respond_to(:get_registration_tags) }
    it { should respond_to(:set_registration_tags) }
    it { should respond_to(:add_registration_tag) }
    it { should respond_to(:remove_registration_tag) }
  end
end

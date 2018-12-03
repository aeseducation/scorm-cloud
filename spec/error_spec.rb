require 'spec_helper'

describe "Rustici Web Service API" do
  describe ScormCloud::RequestError do
    let(:url) { "http://some.url" }

    describe "known errors" do
      let(:known_xml_error) { %q{<?xml version="1.0" encoding="utf-8" ?><rsp stat="ok"><err code="1" msg="oops"/></rsp>} }
      let(:doc) { REXML::Document.new(known_xml_error) }
      subject { described_class.new(doc, url) }

      it "sets the code" do
        expect(subject.code).to eq "1"
      end

      it "sets the msg" do
        expect(subject.msg).to eq "oops"
      end

      it "builds the error message" do
        expect(subject.to_s).to match(/error in scorm cloud: error=1 message=oops url=/i)
      end
    end

    describe "handles unknown errors" do
      let(:unknown_xml_error) { %q{<?xml version="1.0" encoding="utf-8" ?><rsp stat="ok"><bogus/></rsp>} }
      let(:doc) { REXML::Document.new(unknown_xml_error) }
      subject { described_class.new(doc, url) }

      it "deos not set the code" do
        expect(subject.code).to eq nil
      end

      it "builds a generic error message" do
        expect(subject.msg).to match(/request failed with an unknown error. entire response: .*<bogus\/>/i)
      end

    end
  end
end

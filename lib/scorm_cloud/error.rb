module ScormCloud
  class Error < RuntimeError
  end

  class RequestError < Error
    attr_reader :code, :msg, :url

    def initialize(doc, url)
      err = doc.elements["rsp"].try(:elements).try(:[], "err")
      if err
        code = err.attributes["code"]
        msg = err.attributes["msg"]
        super("Error In Scorm Cloud: Error=#{code} Message=#{msg} URL=#{url}")
        @code = code
        @msg = msg
        @url = url
      else
        doc_xml = ''
        doc.write(doc_xml)
        @msg = "Request failed with an unknown error. Entire response: #{doc_xml}"
      end
    end
  end

  class InvalidPackageError < Error
    def initialize
      super('Not a valid SCORM package')
    end
  end
end

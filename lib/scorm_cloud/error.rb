module ScormCloud
  class RequestError < RuntimeError
    attr_reader :code, :msg, :url

    def initialize(doc, url)
      err = doc.elements["rsp"].elements["err"]
      code = err.attributes["code"]
      msg = err.attributes["msg"]
      super("Error In Scorm Cloud: Error=#{code} Message=#{msg} URL=#{url}")
      @code = code
      @msg = msg
      @url = url
    end
  end
end

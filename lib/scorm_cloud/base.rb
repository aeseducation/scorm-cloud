module ScormCloud
  class Base
    attr_reader :appid, :api_url
    attr_accessor :logger

    def initialize(appid, secret, api_url=nil, logger=nil)
      @appid = appid
      @secret = secret
      @api_url = api_url || "https://cloud.scorm.com/api"
      @logger = logger
    end

    def call(method, params = {})
      url = prepare_url(method, params)
      execute_call_xml(url)
    end

    def call_raw(method, params = {})
      url = prepare_url(method, params)
      execute_call_plain(url)
    end     

    def call_url(url)
      execute_call_plain(url)
    end

    def post(method, file, params = {})
      url = URI.parse(prepare_url(method, params))
      body = nil
      block = Proc.new do |f|
          req = Net::HTTP::Post::Multipart.new "#{url.path}?#{url.query}",
            "file" => UploadIO.new(f, "application/zip", "scorm.zip")
          res = Net::HTTP.start(url.host, url.port, use_ssl: url.scheme == "https") do |http|
            http.request(req)
          end
          body = res.body
      end
      if file.respond_to? :read
        block.call(file)
      else
        File.open(file, &block)
      end
      log_request_response(body, url)
      parse_xml_response(body, url.to_s)
    end

    def launch_url(method, params = {})
      prepare_url(method, params)
    end

  private

    # Log the request/response
    def log_request_response(body, url)
      return if logger.nil?
      logger.debug("Request: #{url}")
      logger.debug("Response: #{body}")
    end

    # Get the URL for the call
    def prepare_url(method, params = {})
      timestamp = Time.now.utc.strftime('%Y%m%d%H%M%S')
      params[:method] = method
      params[:appid] = @appid
      params[:ts] = timestamp
      html_params = URI.encode_www_form(params)

      raw = @secret + params.keys.
          sort{ |a,b| a.to_s.downcase <=> b.to_s.downcase }.
          map{ |k| "#{k.to_s}#{params[k]}" }.
          join

      sig = Digest::MD5.hexdigest(raw)
      "#{api_url}?#{html_params}&sig=#{sig}"
    end

    # Get plain response body and parse the XML doc
    def execute_call_xml(url)
      parse_xml_response(execute_call_plain(url), url)
    end

    def parse_xml_response(response, url)
      doc = REXML::Document.new(response)
      raise RequestError.new(doc, url) unless doc.elements["rsp"] && doc.elements["rsp"].attributes["stat"] == "ok"
      doc
    end

    # Execute the call - returns response body or redirect url
    def execute_call_plain(url)
      res = Net::HTTP.get_response(URI.parse(url))
      log_request_response(res.body, url)
      case res
      when Net::HTTPRedirection
        # Return the new URL
        res['location']
      when Net::HTTPSuccess
        res.body
      else
        raise TransportError.new(res)
      end
    end

    # Add services
    def self.add_service(hash)
      hash.each do |name, klass|
        define_method(name) do
          service = instance_variable_get("@#{name.to_s}") 
          unless service
            service = instance_variable_set("@#{name.to_s}", klass.new(self))
          end
          service
        end
      end
    end
  end
end

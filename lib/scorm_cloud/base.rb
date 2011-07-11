module ScormCloud
	class Base

		attr_reader :appid

		def initialize(appid, secret)
			@appid = appid
			@secret = secret
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

		def post(method, path, params = {})
			url = URI.parse(prepare_url(method, params))
			body = nil
			File.open(path) do |f|
  				req = Net::HTTP::Post::Multipart.new "#{url.path}?#{url.query}",
    				"file" => UploadIO.new(f, "application/zip", "scorm.zip")
  				res = Net::HTTP.start(url.host, url.port) do |http|
    				http.request(req)
  				end
  				body = res.body
			end
			REXML::Document.new(body)
		end

		def launch_url(method, params = {})
			prepare_url(method, params)
		end


	private

		# Get the URL for the call
		def prepare_url(method, params = {})
			timestamp = Time.now.utc.strftime('%Y%m%d%H%M%S')
			params[:method] = method
			params[:appid] = @appid
			params[:ts] = timestamp
			html_params = params.map { |k,v| "#{k.to_s}=#{v}" }.join("&")

			raw = @secret + params.keys.
					sort{ |a,b| a.to_s.downcase <=> b.to_s.downcase }.
					map{ |k| "#{k.to_s}#{params[k]}" }.
					join

			sig = Digest::MD5.hexdigest(raw)
			"http://cloud.scorm.com/api?#{html_params}&sig=#{sig}"
		end


		# Get plain response body and parse the XML doc
		def execute_call_xml(url)
			doc = REXML::Document.new(execute_call_plain(url))
			raise create_error(doc, url) unless doc.elements["rsp"].attributes["stat"] == "ok"
			doc
		end

		# Execute the call - returns response body or redirect url
		def execute_call_plain(url)
			res = Net::HTTP.get_response(URI.parse(url))
			case res
			when Net::HTTPRedirection
				# Return the new URL
				res['location']
			when Net::HTTPSuccess
				res.body
			else
				raise "HTTP Error connecting to scorm cloud: #{res.inspect}"
			end
		end

	
		# Create an exception with code & message
		def create_error(doc, url)
			err = doc.elements["rsp"].elements["err"]
			code = err.attributes["code"]
			msg = err.attributes["msg"]
			"Error In Scorm Cloud: Error=#{code} Message=#{msg} URL=#{url}"
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

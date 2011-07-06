module ScormCloud
	class Base

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

		# Get plain response body and parse the XML doc
		def execute_call_xml(url)
			doc = REXML::Document.new(execute_call_plain(url))
			raise create_error(doc) unless doc.elements["rsp"].attributes["stat"] == "ok"
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


		# Create an exception with code & message
		def create_error(doc)
			err = doc.elements["rsp"].elements["err"]
			code = err.attributes["code"]
			msg = err.attributes["msg"]
			"Error In Scorm Cloud: Error=#{code} Message=#{msg}"
		end

	end
end

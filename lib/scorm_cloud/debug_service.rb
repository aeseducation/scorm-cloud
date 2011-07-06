module ScormCloud
	class DebugService < BaseService

		def ping()
			url = "http://cloud.scorm.com/api?method=rustici.debug.ping"
			data = connection.call_url(url)
			raise "Bad Server Response" unless data.include?("pong")
			"pong"
		end

		def auth_ping()
			xml = connection.call("rustici.debug.authPing")
			raise "Bad Server Response" unless xml.elements["/rsp/pong"]
			"pong"
		end

		def get_time()
			xml = connection.call("rustici.debug.getTime")
			time = xml.elements["//currenttime"]
			raise "Bad Server Response" unless time
			time.text
		end

	end
end

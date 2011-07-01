module ScormCloud
	class DebugService

		def ping(connection)
			url = "http://cloud.scorm.com/api?method=rustici.debug.ping"
			xml = connection.execute_call_xml(url)
			raise "Bad Server Response" unless xml.elements["/rsp/pong"]
			"pong"
		end

		def auth_ping(connection)
			xml = connection.call("rustici.debug.authPing")
			raise "Bad Server Response" unless xml.elements["/rsp/pong"]
			"pong"
		end

		def get_time(connection)
			xml = connection.call("rustici.debug.getTime")
			time = xml.elements["//currenttime"]
			raise "Bad Server Response" unless time
			time.text
		end

	end
end

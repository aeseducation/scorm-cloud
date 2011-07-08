module ScormCloud
	class BaseService

		def initialize(connection)
			@connection = connection
		end

		def connection
			@connection
		end

		def self.not_implemented(*methods)
			methods.each do |method|
				define_method(method) { raise "Not Implemented: #{method.to_s}" }
 			end
		end

		# Convert xml attributes to hash { :name => value }
		def xml_to_attributes(xml)
			xml.elements["/rsp/attributes"].inject({}) { |h,e| 
				h[e.attributes["name"].to_sym] = e.attributes["value"]
				h 
			}
		end

	end
end

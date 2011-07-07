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

	end
end

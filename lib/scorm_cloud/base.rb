module ScormCloud
	class Base

		def self.not_implemented(*methods)
			methods.each do |method|
				define_method(method) { raise "Not Implemented: #{method.to_s}" }
 			end
		end

	end
end

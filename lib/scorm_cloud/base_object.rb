module ScormCloud
	class BaseObject

		def set_attributes(attributes)				
			attributes.each { |k,v| set_attr(k,v) }
		end

		def set_attr(k,v)
			f = "#{to_underscore(k)}=".to_sym
			if respond_to?(f) 
				send(f, v)
			else
				raise "Object #{self.class} does not respond to #{to_underscore(k)}"
			end
		end

   def to_underscore(s)
     s.gsub(/(.)([A-Z])/,'\1_\2').downcase
   end

	end
end


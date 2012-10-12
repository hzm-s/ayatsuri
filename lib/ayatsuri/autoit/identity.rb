module Ayatsuri
	module AutoIt
		class Identity
			attr_reader :method, :key

			def initialize(spec)
				@method = spec.keys[0]
				@key = spec.values[0]
			end

			def ==(other)
				other.instance_of?(self.class) &&
					self.method == other.method &&
					self.key == other.key
			end
		end
	end
end

module Ayatsuri
	class Application
		class Control
			attr_reader :identification

			def initialize(id_spec)
				@identification = AutoIt::Identification.new(id_spec)
			end

			def ==(other)
				other.instance_of?(self.class) &&
					self.identification == other.identification
			end
		end
	end
end

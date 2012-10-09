module Ayatsuri
	class Application
		
		class Window
			attr_reader :parent, :identification

			def initialize(parent, id_spec)
				@parent = parent
				@identification = AutoIt::Identification.new(id_spec)
				@children = {}
			end

			def append_child(name, component)
				@children[name] = component
				self
			end

			def child(name)
				@children[name]
			end

			def ==(other)
				other.instance_of?(self.class) &&
					self.parent == other.parent &&
					self.identification == other.identification
			end
		end
	end
end

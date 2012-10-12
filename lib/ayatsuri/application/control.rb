module Ayatsuri
	class Application
		class Control
			attr_reader :component_type, :parent, :identity

			def initialize(component_type, parent, id_spec)
				@component_type, @parent = component_type, parent
				@identity = AutoIt::Identity.new(id_spec)
			end

			def click
				parent.operate(:click, self)
			end

			def ==(other)
				other.instance_of?(self.class) &&
					self.component_type == other.component_type &&
					self.parent == other.parent &&
					self.identity == other.identity
			end
		end
	end
end

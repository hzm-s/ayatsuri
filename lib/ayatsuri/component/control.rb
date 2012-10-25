module Ayatsuri
	module Component
		class Control

			class << self

				def create(parent, component_type, identifier)
					new(parent, component_type, identifier)
				end
			end

			attr_reader :component_type, :identifier

			def initialize(parent, component_type, identifier)
				@parent = parent
				@component_type = component_type
				@identifier = identifier
			end

			def parent_identifier
				@parent.identifier
			end
		end
	end
end

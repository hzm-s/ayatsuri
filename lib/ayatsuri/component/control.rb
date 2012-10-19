module Ayatsuri
	module Component
		class Control

			class << self

				def create(driver, parent, component_type, identifier)
					new(driver, parent, component_type, identifier)
				end
			end

			attr_reader :component_type, :identifier

			def initialize(driver, parent, component_type, identifier)
				@driver = driver
				@parent = parent
				@component_type = component_type
				@identifier = identifier
			end

			def parent_identifier
				@parent.identifier
			end

			def click
				@driver.click(self)
			end

			def content
				@driver.get_content(self)
			end
		end
	end
end

module Ayatsuri
	module Component
		class Control
			attr_reader :component_type

			class << self

				def create(driver, parent, component_type, identifier)
					new(driver, parent, component_type, identifier)
				end
			end

			def initialize(driver, parent, component_type, identifier)
				@driver, @parent, @component_type, @identifier = driver, parent, component_type, identifier
			end

			def click
				@driver.click(self)
			end
		end
	end
end

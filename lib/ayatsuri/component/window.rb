module Ayatsuri
	module Component
		
		class Window

			class << self

				def create(driver, identifier)
					new(driver, identifier)
				end
			end

			attr_reader :driver, :title

			def initialize(driver, identifier)
				@driver, @identifier = driver, identifier
				@children = Repository.new
			end

			def append_child(name, component)
				@children.register(name, component)
			end

			def find_child(component_type, name)
				@children.fetch(component_type, name)
			end

			def component_type
				:window
			end
		end
	end
end

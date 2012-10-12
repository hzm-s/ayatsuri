module Ayatsuri
	class Application
		class Window
			class ComponentManager

				def initialize
					@components = {}
				end

				def register(name, component)
					raise ArgumentError unless name and component
					container_for_component(component)[name] = component
					self
				end

				def fetch(type, name)
					container_for_component_type(type)[name]
				end

			private

				def container_for_component(component)
					@components[component.component_type] ||= {}
				end

				def container_for_component_type(type)
					@components[type]
				end
			end
		end
	end
end

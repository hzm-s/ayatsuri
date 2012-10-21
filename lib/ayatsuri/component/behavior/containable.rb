module Ayatsuri
	module Component
		module Behavior
			module Containable

				def child_repository
					@child_repository ||= Repository.new
				end

				def append_child(name, child)
					child_repository.register(name, child)
					self
				end

				def find_child(component_type, name)
					child_repository.fetch(component_type, name)
				end
			end
		end
	end
end

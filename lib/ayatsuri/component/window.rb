require 'ayatsuri/component/base'

module Ayatsuri
	module Component
		class Window < Base
			include Behavior::Containable

		end
	end
end
__END__

			class << self

				def create(driver, identifier)
					new(driver, driver.create_window_identifier(identifier))
				end
			end

			attr_reader :driver, :identifier

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

			def activate
				@driver.activate(self)
			end
		end
	end
end

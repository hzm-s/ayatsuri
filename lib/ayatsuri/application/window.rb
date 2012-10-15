module Ayatsuri
	class Application
		
		class Window
			attr_reader :driver, :title

			def initialize(driver, title)
				@driver, @title = driver, title
				@component_manager = ComponentManager.new
			end

			def build(&building_block)
				Builder.new(self).instance_exec(&building_block)
			end

			def append_child(name, component)
				@component_manager.register(name, component)
				self
			end

			def find_child(type, name)
				@component_manager.fetch(type, name)
			end

			def operate(action, control)
				@driver.send(action, self, control)
			end

			def activate
				@driver.activate_window(self)
			end

			def component_type
				:window
			end

			def ==(other)
				other.instance_of?(self.class) &&
					self.title == other.title
			end
		end
	end
end

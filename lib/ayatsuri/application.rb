require 'ayatsuri/driver'
require 'ayatsuri/component'

module Ayatsuri
	class Application

		class << self
			RootWindow = Struct.new("RootWindow", :name, :window)

			def inherited(child_class)
				child_class.initialize_application
				super
			end

			def initialize_application
				self.instance_variable_set(:@driver, nil)
				self.instance_variable_set(:@root_window, nil)
			end

			def ayatsuri_for(exe, root_window_identifier, &build_block)
				@driver = Driver.create("autoit", exe)
				builder = Component::Builder.new(@driver, self)
				builder.window("root", root_window_identifier, &build_block)
				self
			end

			def append_child(name, child)
				@root_window = RootWindow.new(name, child)
				child
			end

			def driver
				@driver
			end

			def root_window
				@root_window.window
			end
		end

		def boot
			self.class.driver.boot
		end

		def method_missing(method, *args, &block)
			super unless Component.available_type?(method)
			self.class.root_window.find_child(method, args[0])
		end
	end
end

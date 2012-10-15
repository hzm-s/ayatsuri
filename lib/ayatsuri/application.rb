require 'ayatsuri/driver'
require 'ayatsuri/application/component'
require 'ayatsuri/application/component_builder'
require 'ayatsuri/application/component_repository'

module Ayatsuri
	class Application

		class << self

			def inherited(child_class)
				child_class.initialize_application
				super
			end

			def initialize_application
				self.instance_variable_set(:@driver, nil)
				self.instance_variable_set(:@children, ComponentRepository.new)
				self.instance_variable_set(:@root_window, nil)
			end

			def ayatsuri_for(exe, root_window_identity, &build_block)
				@driver = Driver.create(exe)
				builder = ComponentBuilder.new(@driver, self)
				@root_window = builder.window("root", root_window_identity, &build_block)
			end

			def append_child(name, child)
				@children.register(name, child)
			end
		end
	end
end
__END__

		def driver
			self.class.instance_variable_get(:@driver)
		end

		def root_window
			self.class.instance_variable_get(:@root_window)
		end

		def window(name)
			self.root_window.find_child(:window, name)
		end

		def label(name)
			self.root_window.find_child(:label, name)
		end

		def button(name)
			self.root_window.find_child(:button, name)
		end
	end
end

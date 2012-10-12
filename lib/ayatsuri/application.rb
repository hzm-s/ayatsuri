require 'ayatsuri/application/window'
require 'ayatsuri/driver'

module Ayatsuri
	class Application

		class << self

			def inherited(child)
				child.initialize_application
				super
			end

			def initialize_application
				self.instance_variable_set(:@driver, nil)
				self.instance_variable_set(:@root_window, nil)
			end

			def ayatsuri_for(exe, root_window_title, &bilding_block)
				@driver = AutoIt::Driver.create(exe)
				@root_window = Window.new(@driver, root_window_title).build(&bilding_block)
			end
		end

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

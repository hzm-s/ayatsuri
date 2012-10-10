require 'ayatsuri/application/window'

module Ayatsuri
	class Application

		class << self

			def inherited(child)
				child.initialize_application
				super
			end

			def initialize_application
				self.instance_variable_set(:@exe, nil)
				self.instance_variable_set(:@root_window, nil)
			end

			def ayatsuri_for(exe, root_window_title, &bilding_block)
				@exe = exe
				@root_window = Window.new(root_window_title).build(&bilding_block)
			end
		end

		def exe
			self.class.instance_variable_get(:@exe)
		end

		def root_window
			self.class.instance_variable_get(:@root_window)
		end
	end
end

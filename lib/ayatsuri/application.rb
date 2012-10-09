require 'ayatsuri/application/window'
require 'ayatsuri/application/control'

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

			def ayatsuri_for(exe, root_window_id_spec)
				@exe = exe
				@root_window = Window.new(nil, root_window_id_spec)
			end

			def has_textbox(name, options)
				register_control(name, options)
			end

		private
			
			def register_control(name, options)
				@root_window.register_control(name, options)
			end
		end

		def exe
			self.class.instance_variable_get(:@exe)
		end

		def root_window
			self.class.instance_variable_get(:@root_window)
		end

		def textbox
		end
	end
end

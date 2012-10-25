require 'win32ole'

module Ayatsuri
	module AutomationAdapter
		class Autoit

			def initialize
				@com = WIN32OLE.new('AutoItX3.Control')
			end

			def create_window_identifier(identifier_string)
				identifier_string.encode(Encoding::Windows_31J)
			end

			def run(application)
				@com.Run(application)
			end

			def shutdown!(root_window)
				@com.WinClose(root_window.identifier)
			end

			def activate(window, &block)
				@com.WinActivate(window.identifier)
			end

			def click(control)
				@com.ControlClick(control.parent_identifier, "", control.identifier)
			end

			def get_content(control)
				@com.ControlGetText(control.parent_identifier, "", control.identifier)
			end
		end
	end
end

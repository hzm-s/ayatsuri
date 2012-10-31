require 'win32ole'

module Ayatsuri
	module AutomationAdapter
		class Autoit

			def initialize
				@com = WIN32OLE.new('AutoItX3.Control')
			end

			def run(application)
				@com.Run(application)
			end

			def shutdown!(root_window)
				@com.WinClose(root_window.identifier)
			end
		end
	end
end

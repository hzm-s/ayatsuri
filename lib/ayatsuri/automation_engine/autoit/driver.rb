require 'win32ole'
require 'singleton'

module Ayatsuri
	module AutoIt

		class Win32COMFactory

			class << self
				@created_com = nil

				def create
					@created_com ||= WIN32OLE.new("AutoItX3.Control")
				end
			end
		end

		class Driver
			@created_drivers = {}

			class << self
				attr_reader :created_drivers

				def create(exe)
					created_drivers[exe] ||= new(Win32COMFactory.create, exe)
				end
			end

			def initialize(com, exe)
				@com, @exe = com, exe
			end

			private_class_method :new

			def boot_application
				@com.Run(@exe)
			end

			def activate_window(window)
				boot_application
				@com.WinWaitActive(window.title)
			end

			def click(window, control)
				boot_application
				window.activate
				@com.ControlClick(window.title, "", control.id)
			end
		end
	end
end

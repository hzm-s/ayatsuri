require 'win32ole'

module Ayatsuri
	class Driver

		module QueryMethods

			class << self

				def encoding=(encoding)
					Encoding.default_internal = encoding
				end
			end

			def get_active_window_handle
				ole.WinGetHandle("[active]")
			end

			def get_active_window_title
				ole.WinGetTitle("[active]").encode
			end

			def get_active_window_text
				ole.WinGetText("[active]").encode
			end

			def get_control_text(control_id)
				ole.ControlGetText("[active]", "", control_id).encode
			end
		end
	end

	class Driver
		@instance = nil

		class << self

			def instance
				@instance ||= new
			end

			def flush
				@instance = nil
			end
		end

		def initialize
			@ole = WIN32OLE.new('AutoItX3.Control')
		end

		private_class_method :new

		def invoke(method, args)
			ole.send(method, *args)
		rescue => e
			raise FailedToOperate, e.message
		end
	
	protected

		def ole; @ole; end
	end
end

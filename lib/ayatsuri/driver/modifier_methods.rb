module Ayatsuri
	class Driver
		module ModifierMethods
			include EncodeHelper

			def input(stuff)
				modify(:Send, stuff)
			end

			def close_window(window_title)
				modify(:WinClose, [window_title])
			end

		private

			def modify(method, args)
				ole.send(method, *encode_for_driver(args))
			end
		end
	end
end

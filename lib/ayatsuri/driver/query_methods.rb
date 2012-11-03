module Ayatsuri
	class Driver
		module QueryMethods
			include EncodeHelper

			def get_active_window_handle
				query(:WinGetHandle, ["[active]"])
			end

			def get_active_window_title
				query(:WinGetTitle, ["[active]"])
			end

			def get_active_window_text
				query(:WinGetText, ["[active]"])
			end

			def get_control_text(control_id)
				query(:ControlGetText, ["[active]", "", control_id])
			end

			def window_exist?(window_id)
				query(:WinExists, [window_id]) == 1
			end

		private

			def query(method, args)
				encode_for_ayatsuri(
					ole.send(
						method,
						*encode_for_driver(args)
					)
				)
			end
		end
	end
end

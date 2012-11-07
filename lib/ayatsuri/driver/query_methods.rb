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

			def get_window_text(window_title)
				query(:WinGetText, [window_title])
			end

			def window_active?(window_title)
				get_active_window_title == window_title
			end

			def window_exist?(window_title)
				query(:WinExists, [window_title]) == 1
			end

			def get_control_text(window_title, control_id)
				query(:ControlGetText, [window_title, "", control_id])
			end

			def control_enabled?(window_title, control_id)
				query(:ControlCommand, [window_title, "", control_id, "IsEnabled"]) == 1
			end

		private

			def query(method, args)
				encode_for_ayatsuri(
					invoke(
						method,
						encode_for_driver(args)
					)
				)
			end
		end
	end
end

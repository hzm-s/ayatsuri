module Ayatsuri
	class Driver
		module QueryMethods

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

			def window_exist?(window_title)
				query(:WinExists, [window_title])
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

			def encode_for_driver(args)
				args.collect {|arg| arg.encode(Encoding::WINDOWS_31J) if arg.instance_of?(String) }
			end

			def encode_for_ayatsuri(result)
				result.encode(Encoding::UTF_8) if result.instance_of?(String)
			end
		end
	end
end

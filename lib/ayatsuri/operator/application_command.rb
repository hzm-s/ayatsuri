module Ayatsuri
	class Operator
		module ApplicationCommand

			def run(application)
				invoke(:run, application.exe_path)
			end

			def quit(application)
				invoke(:close_active_window, application.opened_windows.size)
			end
		end
	end
end

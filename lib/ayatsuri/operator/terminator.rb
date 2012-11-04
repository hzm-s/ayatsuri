module Ayatsuri
	class Operator
		module Terminator

			def quit_application
				close_windows(window_history.uniq)
			end

			def close_windows(windows)
				windows.select {|window| window_exist?(window.title) }.each do |window|
					close_window(window.title)
				end
			end
		end
	end
end

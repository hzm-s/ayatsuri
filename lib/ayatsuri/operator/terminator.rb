module Ayatsuri
	class Operator
		module Terminator

			def quit_application
				perform_with_callbacks { close_windows(window_history.uniq) }
			end

			def close_windows(windows)
				windows.select {|window| window_exist?(window.title) }.each do |window|
					close_window(window.title)
				end
			end

		private

			def perform_with_callbacks
				invoke_callbacks(:before)
				yield
				invoke_callbacks(:after)
			end

			def invoke_callbacks(stage)
				callback = "#{stage}_quit_application".to_sym
				send(callback) if respond_to?(callback)
			end
		end
	end
end

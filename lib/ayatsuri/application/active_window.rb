module Ayatsuri
	class Application
		class ActiveWindow
			class Dispatcher

				def initialize(starter)
					@starter = starter
				end

				def start(operator)
					active_window = ActiveWindow.init
					@starter.start(operator)
					execute_dispatch_loop(active_window)
				end
			end
		end
	end
end

require 'ayatsuri/application/active_window'

module Ayatsuri
	class Application
		class ActiveWindowDispatcher

			def initialize(starter, operator)
				@starter, @operator = starter, operator
				@active_window = ActiveWindow.init
			end

			def start
				@starter.start
				until @operator.finished?
					@operator.dispatch(@active_window.next)
				end
			end
		end
	end
end

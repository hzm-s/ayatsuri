module Ayatsuri
	class Application
		class ActiveWindow

			class Change
				include Waitable

				TIMEOUT = 60 * 10

				attr_reader :last

				class << self

					def init
						new { Window.active }
					end
				end

				def initialize(&get_active_window_block)
					@get_active_window_block = get_active_window_block
					@last = get_active_window
				end

				def next
					wait_until(TIMEOUT, "active window change") do
						@last != (@current = get_active_window)
					end
					return @last = @current
				end

			private

				def get_active_window
					@get_active_window_block.call
				end
			end
		end

		class ActiveWindow

			class Dispatcher

				def initialize(active_window_change)
					@active_window_change = active_window_change
				end

				def start(operator)
					until operator.completed?
						operator.assign(@active_window_change.next)
					end
				rescue => exception
					raise Ayatsuri::AbortOperationOrder, exception.message
				end
			end
		end
	end
end

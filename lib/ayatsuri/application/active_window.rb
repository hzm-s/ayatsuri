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

				def initialize(active_window_change, operation_order)
					@active_window_change = active_window_change
					@operation_order = operation_order
				end

				def start(operator)
					until operator.completed?
						assign_operation(operator)
					end
				rescue => exception
					raise Ayatsuri::AbortOperationOrder, exception.message
				end

				def assign_operation(operator)
					active_window = @active_window_change.next
					operation = retrieve_operation(active_window)
					operator.assign(operation, active_window)
				end

				def retrieve_operation(active_window)
					@operation_order.retrieve(active_window)
				end
			end
		end
	end
end

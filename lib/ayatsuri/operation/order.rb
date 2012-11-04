module Ayatsuri
	class Operation
		class Order

			class << self

				def create(&order_block)
					operations = Builder.build(&order_block)
					new(operations)
				end
			end

			def initialize(operations)
				@operations = operations
				@operation_iterator = Fiber.new do
					@operations.each do |operation|
						Fiber.yield(operation)
					end
					raise Ayatsuri::NothingNextOperation
				end
			end

			def retrieve(window)
				primary = next_operation
				return primary if primary.assigned?(window)
				return Operation::Unassigned.new(window) unless primary.optional?
				retrieve(window)
			end

			def next_operation
				@operation_iterator.resume
			end
		end
	end
end

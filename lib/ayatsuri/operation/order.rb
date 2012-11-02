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
			end
		end
	end
end

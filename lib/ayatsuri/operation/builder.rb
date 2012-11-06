module Ayatsuri
	class Operation
		class Builder

			class << self

				def build(&order_block)
					builder = new
					builder.instance_eval(&order_block)
					builder.operations
				end
			end

			attr_reader :operations

			def initialize
				@operations = []
			end

			def operate(method_name, option={ limit: 3600 }, &condition_block)
				condition = Condition.new(&condition_block)
				operation = Operation.new(condition, method_name, option)
				add_operation(operation)
			end

			def add_operation(operation)
				@operations << operation
			end
		end
	end
end

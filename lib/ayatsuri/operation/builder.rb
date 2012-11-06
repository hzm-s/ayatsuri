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

			def operate(method_name, if_flag, &condition_block)
				condition = Condition.new(&condition_block)
				operation = Operation.new(condition, method_name, if_flag)
				add_operation(operation)
			end

			def window_title(expect, method_name, optional=true)
				add_operation(
					create_operation(:title, expect, method_name, optional)
				)
			end

			def add_operation(operation)
				@operations << operation
			end

		private

			def create_operation(query_method, expect, method_name, optional)
				Operation.new(
					create_condition(query_method, expect),
					method_name,
					optional
				)
			end

			def create_condition(query_method, expect)
				Condition.create(query_method, expect)
			end
		end
	end
end

require 'ayatsuri/operation'
require 'ayatsuri/application/window/condition'

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
				Application::Window::Condition.create(query_method, expect)
			end
		end
	end
end

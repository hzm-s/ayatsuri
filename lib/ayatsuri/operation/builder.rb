require 'ayatsuri/operation'
require 'ayatsuri/operation/condition'

module Ayatsuri
	class Operation
		class Builder

			class << self

				def build(&plan_block)
					builder = new
					builder.instance_eval(&plan_block).operations
				end
			end

			attr_reader :operations

			def initialize
				@operations = []
			end

			def on(condition_spec, &operation_block)
				add_operation(
					Operation.new(
						Operation::Condition.create(condition_spec),
						&operation_block
					)
				)
				self
			end

			def add_operation(operation)
				@operations << operation
			end
		end
	end
end

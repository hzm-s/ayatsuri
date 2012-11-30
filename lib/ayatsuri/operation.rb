module Ayatsuri
	class Operation
		autoload :Builder,		'ayatsuri/operation/builder'
		autoload :Condition,	'ayatsuri/operation/condition'
		autoload :Decision,		'ayatsuri/operation/decision'
		autoload :Order,			'ayatsuri/operation/order'
	end

	class Operation
		class Dispatcher

			def initialize(operator, order)
				@operator, @order = operator, order
			end

			def start
				until @operator.completed?
					dispatch(@order.next)
				end
				@order
			end

			def dispatch(operation)
				operation.decide(@operator).perform(@operator)
			end
		end
	end

	class Operation

		class << self
			attr_accessor :wait_next_operation_limit
			@wait_next_operation_limit = 3600
		end

		attr_reader :method_name

		def initialize(condition, method_name, option)
			@condition, @method_name = condition, method_name
			@option = option
		end

		def decide(operator)
			return Decision::Assign.new(self) if @condition.match?(operator, @option[:limit] || self.class.wait_next_operation_limit)
			return Decision::Skip.new(self) if @option[:limit]
			return Decision::Timeout.new(self)
		end

		def inspect
			"#{@condition.inspect} => #<Operation:#{@method_name}#{"(optional)" if @optional}>"
		end
	end
end

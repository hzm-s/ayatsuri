module Ayatsuri
	class Operation
		autoload :Builder,		'ayatsuri/operation/builder'
		autoload :Condition,	'ayatsuri/operation/condition'
		autoload :Order,			'ayatsuri/operation/order'
	end

	class Operation
		class Unassigned

			def initialize(window)
				@window = window
			end
		end
	end

	class Operation
		class Dispatcher

			def initialize(operator, order)
				@operator, @order = operator, order
			end

			def start
				until @operator.completed?
					@operator.assign(@order.next)
				end
				@order
			end
		end
	end

	class Operation
		attr_reader :optional, :method_name
		alias_method :optional?, :optional

		def initialize(condition, method_name, optional)
			@condition, @method_name = condition, method_name
			@optional = optional
		end

		def assigned?(window)
			@condition.satisfy?(window)
		end

		def inspect
			"#{@condition.inspect} => #<Operation:#{@method_name}#{"(optional)" if @optional}>"
		end
	end
end

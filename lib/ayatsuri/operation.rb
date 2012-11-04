module Ayatsuri
	class Operation
		autoload :Builder,		'operation/builder'
		autoload :Condition,	'operation/condition'
		autoload :Order,			'operation/order'
	end

	class Operation
		class Unassigned

			def initialize(window)
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
	end
end

module Ayatsuri
	class Operation
		attr_reader :condition, :method_name, :optional
		alias_method :optional?, :optional

		def initialize(condition, method_name, optional)
			@condition, @method_name = condition, method_name
			@optional = optional
		end
	end
end

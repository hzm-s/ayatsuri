module Ayatsuri
	class Operation
		attr_reader :condition, :operation_block

		def initialize(condition, &operation_block)
			@condition = condition
			@operation_block = operation_block
		end
	end
end

require 'ayatsuri/operation/builder'

module Ayatsuri
	class Operation
		class Plan

			class << self

				def create(&plan_block)
					new(Builder.build(&plan_block))
				end
			end

			def initialize(operations)
				@operations = operations
			end
		end
	end
end

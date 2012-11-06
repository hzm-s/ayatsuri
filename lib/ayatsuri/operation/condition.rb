module Ayatsuri
	class Operation
		class Condition
			include Waitable

			attr_reader :block

			def initialize(&expected_condition_block)
				@block = expected_condition_block
			end

			def match?(operator, timeout)
				wait_until(timeout, "condition match") do
					operator.instance_eval(&@block)
				end
			rescue Ayatsuri::Timeout
				false
			else
				true
			end
		end
	end
end

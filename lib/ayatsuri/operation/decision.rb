module Ayatsuri
	class Operation
		class Decision

			class Base

				def initialize(operation)
					@operation = operation
				end

				def perform(operator)
					raise StandardError, "'perform` is not implemented for #{self.class}"
				end
			end

			class Assign < Base

				def perform(operator)
					operator.assign(@operation)
				end
			end

			class Timeout < Base

				def perform(operator)
					raise Ayatsuri::ConditionMatchingTimeout
				end
			end

			class Skip < Base

				def perform(operator)
					operator.skip(@operation)
				end
			end
		end
	end
end

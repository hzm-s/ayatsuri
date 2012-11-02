__END__
require 'ayatsuri/operation/condition/matcher'

module Ayatsuri
	class Operation
		class Condition

			class << self

				def create(spec)
					case spec
					when Hash
						new(*resolve_spec(spec))
					when Symbol
						create({ spec => true })
					end
				end

			private

				def resolve_spec(spec)
					[ spec.keys[0], Matcher.create(spec.values[0]) ]
				end
			end

			def initialize(method_for_candidate, matcher)
				@method_for_candidate, @matcher = method_for_candidate, matcher
			end

			def satisfy?(candidate)
				match?(candidate.send(@method_for_candidate))
			end
		end
	end
end

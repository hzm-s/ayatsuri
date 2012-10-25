require 'ayatsuri/operation/condition/real_matchers'

module Ayatsuri
	class Operation
		class Condition
			class Matcher
	
				class << self
	
					def create(expectation)
						new(expectation, real_matcher(expectation))
					end

				private

					def real_matcher(expectation)
						case expectation
						when Regexp
							RegexpMatcher
						else
							ValueMatcher
						end
					end
				end

				def initialize(expectation, real_matcher)
					@expectation, @real_matcher = expectation, real_matcher
				end

				def match?(actual)
					@real_matcher.match?(actual, @expectation)
				end
			end
		end
	end
end

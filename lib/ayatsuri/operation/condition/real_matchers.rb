module Ayatsuri
	class Operation
		class Condition

			module RegexpMatcher
				
				def self.match?(actual, expectation)
					actual =~ expectation
				end
			end

			module ValueMatcher

				def self.match?(actual, expectation)
					actual == expectation
				end
			end

		end
	end
end

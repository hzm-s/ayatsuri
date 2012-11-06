module Ayatsuri
	class Operation
		class Condition

			class Matcher
				module ByRegexp

					def match?(actual)
						actual =~ self.expectation
					end
				end

				module ByEqual

					def match?(actual)
						actual == self.expectation
					end
				end

				class << self

					def create(expectation)
						new(expectation).extend(strategy_module(expectation))
					end

				private

					def strategy_module(expectation)
						case expectation
						when Regexp
							ByRegexp
						else
								ByEqual
						end
					end
				end

				attr_reader :expectation

				def initialize(expectation)
					@expectation = expectation
				end

				def inspect
					"#<Condition::Matcher:#{@expectation}>"
				end
			end

			class << self

				def create(query_method, expectation)
					new(query_method, Matcher.create(expectation))
				end
			end

			def initialize(query_method, matcher)
				@query_method, @matcher = query_method, matcher
			end

			def satisfy?(candidate)
				@matcher.match?(candidate.send(@query_method))
			end

			def inspect
				"#{@matcher.inspect} => #{@query_method}>"
			end
		end
	end
end

module Ayatsuri
	module Component
		module Behavior
			module Containable

				class << self
					def included(base)
						base.send :alias_method, :initialize_without_containable, :initialize
						base.send :alias_method, :initialize, :initialize_with_containable
						base.attr_reader :child_repository
					end
				end

				def initialize_with_containable
					@child_repository = Repository.new
				end
			end
		end
	end
end

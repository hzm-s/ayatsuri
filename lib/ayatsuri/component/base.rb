require 'ayatsuri/component/behavior/containable'

module Ayatsuri
	module Component
		class Base
			attr_reader :parent, :id

			def initialize(parent, id)
				@parent, @id = parent, id
			end
		end
	end
end

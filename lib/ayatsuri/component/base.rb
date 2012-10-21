require 'ayatsuri/component/behavior/containable'

module Ayatsuri
	module Component
		class Base
			attr_reader :driver, :parent, :id

			def initialize(driver, parent, id)
				@driver, @parent, @id = driver, parent, id
			end

			def invoke(operation, *args)
				driver.send(operation, *args)
			end
		end
	end
end

module Ayatsuri
	module Component
		class Base
			attr_reader :driver, :id

			def initialize(driver, id)
				@driver, @id = driver, id
			end

			def invoke(operation, *args)
				driver.send(operation, *args)
			end
		end
	end
end

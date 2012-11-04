module Ayatsuri
	class Operator
		module ActionProxy

			def method_missing(method, *args, &block)
				super unless self.driver.respond_to?(method)
				self.driver.send(method, *args, &block)
			end
		end
	end
end

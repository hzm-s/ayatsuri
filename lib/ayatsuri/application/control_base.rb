module Ayatsuri
	class Application
		class ControlBase
			attr_reader :window, :id

			def initialize(window, id)
				@window, @id = window, id
			end

		protected

			def driver
				window.driver
			end
		end
	end
end

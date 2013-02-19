module Ayatsuri
	class Application
		class Coordinate

			def initialize(window, x, y)
				@window, @x, @y = window, x, y
			end

			def click(button=:left)
				@window.driver.click_coordinate(button.to_s, @x, @y, 1)
			end
		end
	end
end

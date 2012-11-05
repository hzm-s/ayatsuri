module Ayatsuri
	class Application
		class Control
			attr_reader :window, :id

			def initialize(window, id)
				@window, @id = window, id
			end

			def focus
				driver.focus_control(window.title, id)
			end

			def click
				driver.click_control(window.title, id)
			end

			def text=(text)
				driver.set_text_to_control(window.title, id, text)
			end

			def text
				driver.get_control_text(window.title, id)
			end

			def enabled?
				driver.control_enabled?(window.title, id)
			end

			def not_enabled?
				!enabled?
			end

		private

			def driver
				window.driver
			end
		end
	end
end

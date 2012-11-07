module Ayatsuri
	class Application
		class Control < ControlBase

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
		end
	end
end

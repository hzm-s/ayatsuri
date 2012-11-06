module Ayatsuri
	class Application
		class Window

			class << self

				def active
					driver = Driver.instance
					new(
						driver,
						driver.get_active_window_handle,
						driver.get_active_window_title
					)
				end
			end

			attr_reader :handle, :title, :driver

			def initialize(driver, handle, title)
				@driver = driver
				@handle, @title = handle, title
			end

			def text
				driver.get_window_text(title)
			end

			def active?
				driver.window_active?(title)
			end

			def not_active?
				!active?
			end

			def exist?
				driver.window_exist?(title)
			end

			def not_exist?
				!exist?
			end

			def control(control_id)
				Control.new(self, control_id)
			end

			def inspect
				"#<Window:#{handle}(#{title.encode(Encoding::WINDOWS_31J)})>"
			end

			def ==(other)
				other.instance_of?(self.class) &&
					self.handle == other.handle# &&
					#self.title == other.title
			end
		end
	end
end

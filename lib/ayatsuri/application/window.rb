module Ayatsuri
	class Application
		class Window

			class << self

				def active
					new(
						Driver.instance.get_active_window_handle,
						Driver.instance.get_active_window_title
					)
				end
			end

			attr_reader :handle, :title

			def initialize(handle, title)
				@handle, @title = handle, title
			end

			def ==(other)
				other.instance_of?(self.class) &&
					self.handle == other.handle &&
					self.title == other.title
			end
		end
	end
end

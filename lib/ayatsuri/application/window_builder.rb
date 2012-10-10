module Ayatsuri
	class Application
		class WindowBuilder

			def initialize(parent)
				@parent = parent
			end

			def window(name, title)
				@parent.append_child(name, Window.new(title))
			end
		end
	end
end

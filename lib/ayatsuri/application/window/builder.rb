require 'ayatsuri/application/control'

module Ayatsuri
	class Application
		class Window
			class Builder

				def initialize(window)
					@window = window
				end
	
				def window(name, title)
					@window.append_child(name, Window.new(@window.driver, title))
				end
	
				def label(name, id_spec)
					@window.append_child(name, Control.new(:label, @window, id_spec))
				end

				def button(name, id_spec)
					@window.append_child(name, Control.new(:button, @window, id_spec))
				end
			end
		end
	end
end

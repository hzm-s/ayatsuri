require 'ayatsuri/application/window_builder'

module Ayatsuri
	class Application
		
		class Window
			attr_reader :title

			def initialize(title)
				@title = title
			end

			def build(&building_block)
				WindowBuilder.new(self).instance_exec(&building_block)
			end

			def ==(other)
				other.instance_of?(self.class) &&
					self.title == other.title
			end
		end
	end
end

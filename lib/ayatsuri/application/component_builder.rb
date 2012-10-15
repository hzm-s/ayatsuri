require 'ayatsuri/application/window'

module Ayatsuri
	class Application
		class ComponentBuilder

			def initialize(driver, parent)
				@driver, @parent = driver, parent
			end

			def window(name, spec, &build_block)
				window = Window.new(@driver, component_identity(spec))
				if build_block
					@parent.append_child(
						name,
						self.class.new(@driver, window).instance_exec(&build_block)
					)
				else
					@parent.append_child(name, window)
				end
			end

		private

			def component_identity(spec)
				@driver.create_identity(spec)
			end
		end
	end
end

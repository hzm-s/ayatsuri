require 'ayatsuri/component/window'
require 'ayatsuri/component/control'

module Ayatsuri
	module Component
		class Builder
			@buildable_control_types = [:label, :button, :textbox]

			class << self
				attr_accessor :buildable_control_types
			end

			def initialize(driver, parent)
				@driver, @parent = driver, parent
			end

			def window(name, identifier, &build_block)
				window = Window.create(@driver, identifier)
				if build_block
					@parent.append_child(
						name,
						self.class.new(@driver, window).instance_exec(&build_block)
					)
				else
					@parent.append_child(name, window)
				end
			end

			def method_missing(method, *args, &block)
				super unless self.class.buildable_control_types.include?(method)
				build_control(method, *args)
			end

		private

			def build_control(type, name, identifier)
				Control.create(@driver, @parent, type, identifier).tap {|control|
					@parent.append_child(name, control)
				}
				@parent
			end
		end
	end
end

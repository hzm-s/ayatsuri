require 'ayatsuri/component/window'
require 'ayatsuri/component/control'
require 'ayatsuri/component/repository'

module Ayatsuri
	module Component
		class Builder
			attr_reader :parent

			def initialize(parent)
				@parent = parent
			end

			def build(&build_child_components_block)
				self.instance_exec(&build_child_components_block)
			end

			def method_missing(method, *args, &block)
				parent.append_child(args[0], child_component(method, args[1]))
			rescue UnavailableComponentType
				raise $!
			rescue => exception
				super
			end

		private

			def child_component(type, id)
				Component.create(type, self.parent.driver, id)
			end
		end
	end
end
__END__
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

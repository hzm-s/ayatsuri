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

			def build(&create_child_block)
				self.instance_exec(&create_child_block)
			end

			def method_missing(method, *args, &block)
				parent.append_child(args[0], create_child_component(method, args[1]))
			rescue UnavailableComponentType
				raise $!
			rescue => exception
				super
			end

		private

			def create_child_component(type, id)
				Component.create(type, parent, id)
			end
		end
	end
end

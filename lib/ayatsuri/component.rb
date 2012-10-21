require 'ayatsuri/component/builder'

module Ayatsuri
	module Component

		extend self

		def create(type, driver, parent, id)
			component_class(type).new(driver, parent, id)
		rescue NameError
			raise UnavailableComponentType.new(type)
		end

		def build(component, &create_child_block)
			Builder.new(component).build(&create_child_block)
		end

	private

		def component_class(type)
			const_get(type.to_s.capitalize)
		end
	end
end

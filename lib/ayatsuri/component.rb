require 'ayatsuri/component/builder'

module Ayatsuri
	module Component

		extend self

		def create(type, driver, id)
			component_class(type).new(driver, id)
		rescue NameError
			raise UnavailableComponentType.new(type)
		end

		def build(component, &build_child_components_block)
			Builder.new(component).build(&build_child_components_block)
		end

	private

		def component_class(type)
			const_get(type.to_s.capitalize)
		end
	end
end

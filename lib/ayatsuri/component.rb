require 'ayatsuri/component/builder'
require 'ayatsuri/component/repository'

module Ayatsuri
	module Component
		@available_types = [:window, :label, :button, :textbox]

		extend self

		attr_accessor :available_types

		def available_type?(type)
			available_types.include?(type)
		end
	end
end

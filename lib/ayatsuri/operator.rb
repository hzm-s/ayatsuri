module Ayatsuri
	class Operator
		attr_reader :operation_order, :params, :completed
		alias_method :completed?, :completed

		def initialize(operation_order, params)
			@operation_order, @params = operation_order, params
			@completed = false
		end

		def complete!
			@completed = true
			quit_application
			self
		end

		def quit_application
			close_all_opened_window
		end
	end
end

require 'ayatsuri/operation/order'
require 'ayatsuri/application/starter'
require 'ayatsuri/application/active_window'

module Ayatsuri
	class Application
		class Process

			def initialize(starter, operator)
				@starter, @operator = starter, operator
			end

			def run
				active_window_dispatcher = ActiveWindow::Dispatcher.new(@starter)
				active_window_dispatcher.start(@operator)
			end
		end

		class << self
			APPLICATION_ATTRIBUTE_METHODS = [:starter, :operator_class, :operation_order]

			attr_reader *APPLICATION_ATTRIBUTE_METHODS

			def ayatsuri_for(exe_path, starter_name=:default)
				@starter = Starter.create(exe_path, starter_name)
			end

			def define_operation_order(operator_class, &order_block)
				@operator_class = operator_class
				@operation_order = Operation::Order.create(&order_block)
			end

			def application_attribute_methods
				APPLICATION_ATTRIBUTE_METHODS
			end
		end

		def run(task_parameters)
			operator = operator_class.new(operation_order, task_parameters)
			process = Process.new(starter, operator)
			process.run
		end

		def method_missing(method, *args, &block)
			super unless self.class.application_attribute_methods.include?(method)
			self.class.send(method)
		end
	end
end

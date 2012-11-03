module Ayatsuri
	class Application
		autoload :ActiveWindow,	'application/active_window'
		autoload :Starter,			'application/starter'
		autoload :Window,				'application/window'

		class Process
			attr_reader :starter, :operator, :dispatcher

			def initialize(starter, operator)
				@starter, @operator = starter, operator
				@dispatcher = nil
			end

			def run
				init_dispatcher
				start_application
				start_dispatch
			end

			def init_dispatcher
				@dispatcher = ActiveWindow::Dispatcher.new(ActiveWindow::Change.init)
			end

			def start_application
				@starter.start
			end

			def start_dispatch
				dispatcher.start(operator)
			rescue => exception
				operator.quit_application
				raise exception
			end
		end
	end

	class Application

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

		def run(*task_parameters)
			operator = operator_class.new(operation_order, *task_parameters)
			process = Process.new(starter, operator)
			process.run
		end

		def method_missing(method, *args, &block)
			super unless self.class.application_attribute_methods.include?(method)
			self.class.send(method)
		end
	end
end

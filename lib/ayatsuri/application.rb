module Ayatsuri
	class Application
		autoload :ActiveWindow,	'application/active_window'
		autoload :Starter,			'application/starter'
		autoload :Window,				'application/window'
	end

	class Application
		class Process
			attr_reader :dispatcher

			def initialize(starter, operation_order, operator)
				@starter, @operation_order, @operator = starter, operation_order, operator
				@dispatcher = nil
			end

			def run
				start_application
				start_dispatch
			end

			def init_dispatcher
				@dispatcher = ActiveWindow::Dispatcher.new(
					ActiveWindow::Change.init,
					@operation_order
				)
			end

			def start_application
				@starter.start(self)
			end

			def start_dispatch
				dispatcher.start(@operator)
			rescue => exception
				@operator.quit_application
				raise exception
			end
		end
	end

	class Application

		class << self
			APPLICATION_ATTRIBUTE_METHODS = [:starter, :operator_class, :operation_order]

			attr_reader *APPLICATION_ATTRIBUTE_METHODS

			def ayatsuri_for(exe_path, starter_name=:Default)
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

		def run(params_for_operator)
			operator = operator_class.new(params_for_operator)
			process = Process.new(starter, operation_order, operator)
			process.run
		end

		def method_missing(method, *args, &block)
			super unless self.class.application_attribute_methods.include?(method)
			self.class.send(method)
		end
	end
end

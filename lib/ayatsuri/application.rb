module Ayatsuri
	class Application
		autoload :ActiveWindow,	'ayatsuri/application/active_window'
		autoload :Control,			'ayatsuri/application/control'
		autoload :ControlBase,	'ayatsuri/application/control_base'
		autoload :Starter,			'ayatsuri/application/starter'
		autoload :TreeView,			'ayatsuri/application/tree_view'
		autoload :Window,				'ayatsuri/application/window'
		autoload :Coordinate,		'ayatsuri/application/coordinate'
	end

	class Application
		class Process

			def initialize(starter, operation_order, operator)
				@starter, @operation_order, @operator = starter, operation_order, operator
			end

			def run
				start_application
				start_dispatch
			end

			def start_application
				@starter.start
			end

			def dispatcher
				@dispatcher ||= Operation::Dispatcher.new(@operator, @operation_order)
			end

			def start_dispatch
				dispatcher.start
			rescue => exception
				@operator.abort
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
				@operator_class, @order_block = operator_class, order_block
				@operation_order = Operation::Order.create(&@order_block)
			end

			def reset_operation_order
				@operation_order = Operation::Order.create(&@order_block)
			end

			def application_attribute_methods
				APPLICATION_ATTRIBUTE_METHODS
			end
		end

		def run(params_for_operator)
			operator = operator_class.new(params_for_operator)
			process = Process.new(starter, operation_order, operator)
			process.run
		rescue => e
			raise e
		ensure
			self.class.reset_operation_order
		end

		def method_missing(method, *args, &block)
			super unless self.class.application_attribute_methods.include?(method)
			self.class.send(method)
		end
	end
end

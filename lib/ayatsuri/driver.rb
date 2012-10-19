Dir["#{File.dirname(__FILE__)}/automation_adapter/**"].each {|f| require f }

module Ayatsuri
	class Driver
		@created_drivers = {}

		class << self
			attr_reader :created_drivers

			def create(automation_adapter_name)
				created_drivers[automation_adapter_name] ||= create_driver(automation_adapter_name)
			end

			def flush
				@created_drivers = {}
			end

		private

			def create_driver(automation_adapter_name)
				new(automation_adapter_class(automation_adapter_name))
			end

			def automation_adapter_class(name)
				Ayatsuri::AutomationAdapter.const_get(name.capitalize.to_sym)
			end
		end

		attr_reader :adapter

		def initialize(automation_adapter_class)
			@adapter = automation_adapter_class.new
		end

		def method_missing(method, *args, &block)
			raise OperationNotImplement.new(adapter.class, method) unless adapter.respond_to?(method)
			adapter.send(method, *args, &block)
		end

		private_class_method :new
	end
end

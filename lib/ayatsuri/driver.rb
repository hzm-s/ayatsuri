Dir["#{File.dirname(__FILE__)}/automation_adapter/**"].each {|f| require f }

module Ayatsuri
	class Driver
		@created_drivers = {}

		class << self
			attr_reader :created_drivers

			def create(automation_adapter_name, exe)
				created_drivers[exe] ||= create_driver(automation_adapter_name, exe)
			end

			def flush
				@created_drivers = {}
			end

		private

			def create_driver(automation_adapter_name, exe)
				new(automation_adapter_module(automation_adapter_name), exe)
			end

			def automation_adapter_module(adapter_name)
				Ayatsuri::AutomationAdapter.const_get(adapter_name.capitalize.to_sym)
			end
		end

		def initialize(automation_adapter_module, exe)
			@exe = exe
			extend automation_adapter_module
		end

		private_class_method :new
	end
end

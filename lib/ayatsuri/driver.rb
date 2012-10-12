require 'ayatsuri/automation_engine/autoit'

module Ayatsuri
	class Driver
		@created_drivers = {}

		class << self
			attr_reader :created_drivers

			def create(exe, automation_engine=AutoIt)
				created_drivers[exe] ||= create_driver(exe, automation_engine)
			end

		private

			def create_driver(exe, automation_engine)
				new(exe, automation_engine_module(automation_engine))
			end

			def automation_engine_module(engine)
				Ayatsuri::AutomationEngine.const_get(engine.to_s.to_sym)
			end
		end

		def initialize(exe, automation_engine)
			extend automation_engine
		end

		private_class_method :new

		def drive(method, *args)
			@automation_engine_interface.send(method.to_sym, *args)
		end
	end
end

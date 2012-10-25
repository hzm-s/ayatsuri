require 'ayatsuri/driver'
require 'ayatsuri/application'
require 'ayatsuri/operator'
require 'ayatsuri/operation/plan'

module Ayatsuri
	class Base

		class << self
			attr_reader :driver, :application

			def ayatsuri_for(automation_adapter=:autoit, application_exe_path)
				@driver = Driver.create(automation_adapter)
				@application = Application.new(application_exe_path)
				self
			end
		end

		attr_reader :operator

		def initialize
			self.class.tap do |klass|
				@operator = Operator.new(klass.driver, klass.application)
			end
		end

		def operate(&plan_block)
			operator.perform(Operation::Plan.create(&plan_block))
		end
	end
end

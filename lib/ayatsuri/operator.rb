require 'ayatsuri/operator/application_command'

module Ayatsuri
	class Operator
		include ApplicationCommand

		def initialize(driver, application)
			@driver, @application = driver, application
		end

		def invoke(method, *args)
			@driver.send(method, *args)
		end

		def perform(plan)
			begin
				run_application
				operate(plan)
			rescue => exception
				raise exception
			ensure
				quit_application
			end
		end

		def run_application
			@application.run(self)
		end

		def operate(plan)
			plan.each_operation {|operation| operation.perform(self) }
		end

		def quit_application
			@application.quit(self)
		end
	end
end

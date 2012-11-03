#encoding:utf-8

module Ayatsuri
	class Application
		class Starter

			class Base

				def initialize(exe_path)
					@exe_path = exe_path
				end

				def start
					raise StandardError, "Not implemented #start for #{self.class}"
				end

			protected

				def driver
					Driver.instance
				end
			end
			
			class Default < Base

				def start
					driver.run_application(@exe_path)
				end
			end

			class Clickonce < Base
				include Waitable

				def start
					driver.invoke(:Send, "#r")
					wait_until(3, "win + r") { driver.window_exist?("[CLASS:#32770]") }
					driver.invoke(:Send, "#{@exe_path}{ENTER}")
				end
			end

			class << self

				def create(exe_path, starter_name)
					starter_class = const_get(starter_name.to_s.capitalize)
					starter_class.new(exe_path)
				end
			end
		end
	end
end

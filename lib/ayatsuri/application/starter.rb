module Ayatsuri
	class Application
		class Starter

			class Base

				def initialize(exe_path)
					@exe_path = exe_path
				end

				def start(driver)
					raise StandardError, "Not implemented #start for #{self.class}"
				end
			end
			
			class Default < Base

				def start(driver)
					driver.run_application(@exe_path)
				end
			end

			class Clickonce < Base

				def start(driver)
					driver.input(:win_r, @exe_path, :enter)
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

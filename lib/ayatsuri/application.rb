require 'ayatsuri/application/starter'
require 'ayatsuri/application/window_manager'
require 'ayatsuri/component'

module Ayatsuri
	class Application
		attr_reader :driver, :exe_path, :window_manager

		attr_reader :running
		alias_method :running?, :running

		def initialize(driver, exe_path)
			@driver, @exe_path = driver, exe_path
			@window_manager = WindowManager.new
			@running = false
		end

		def run
			@driver.run(@exe_path)
		rescue FailedToRunApplication
		else
			@running = true
		end

		def quit
			return nil unless self.running?
			@driver.close_window
		end
	end
end

module Ayatsuri
	class Operator
		autoload :ActionProxy,		'operator/action_proxy'
		autoload :Terminator,			'operator/terminator'
		autoload :WindowHistory,	'operator/window_history'
	end

	class Operator
		include ActionProxy
		include Terminator
		include Waitable

		attr_reader :params, :driver, :window_history, :active_window, :completed
		alias_method :completed?, :completed

		def initialize(params)
			@params = params
			@driver = Driver.instance
			@window_history = WindowHistory.new
			@completed = false
		end

		def assign(operation, window)
			@active_window = window
			window_history << window
			send(operation.method_name)
		end

		def skip
			sleep Interval.skip_operate
		end

		def complete
			complete!
		end

		def complete!
			@completed = true
			quit_application
			self
		end

		def wait_until_close_window(&block)
			block.call
			wait_until { active_window.not_active? }
		end
	end
end

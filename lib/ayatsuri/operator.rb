module Ayatsuri
	class Operator
		autoload :ActionHelper,	'ayatsuri/operator/action_helper'
		autoload :ActionProxy,		'ayatsuri/operator/action_proxy'
		autoload :Terminator,			'ayatsuri/operator/terminator'
		autoload :WindowHistory,	'ayatsuri/operator/window_history'
	end

	class Operator
		include ActionProxy
		include Waitable
		include ActionHelper
		include Terminator

		attr_reader :params, :driver, :window_history, :completed
		alias_method :completed?, :completed

		def initialize(params)
			@params = params
			@driver = Driver.instance
			@window_history = WindowHistory.new
			@completed = false
		end

		def assign(operation)
			log_window_history
			send(operation.method_name)
		end

		def skip
			sleep Interval.skip_operate
		end

		def complete
			complete!
		end

		def abort
			complete!
			@aborted = true
			self
		end

		def complete!
			@completed = true
			quit_application
			self
		end

		def log_window_history
			window_history.log(active_window)
		end
	end
end

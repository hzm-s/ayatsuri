module Ayatsuri
	module Waitable

		def wait_until(timeout=60, message=nil, &block)
			end_time = Time.now + timeout

			until Time.now > end_time
				result = block.call
				return if result

				sleep Interval.application_monitor
			end

			raise Ayatsuri::Timeout, message
		end
	end
end

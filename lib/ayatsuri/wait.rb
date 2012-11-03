module Ayatsuri
	module Waitable
		INTERVAL = 0.1

		def wait_until(timeout=60, message=nil, &block)
			end_time = Time.now + timeout

			until Time.now > end_time
				result = block.call
				return if result

				sleep INTERVAL
			end

			raise Ayatsuri::Timeout, message
		end
	end
end

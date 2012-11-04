module Ayatsuri
	module Waitable
		@interval = 1

		class << self
			attr_accessor :interval
		end

		def wait_until(timeout=60, message=nil, &block)
			end_time = Time.now + timeout

			until Time.now > end_time
				result = block.call
				return if result

				sleep Waitable.interval
			end

			raise Ayatsuri::Timeout, message
		end
	end
end

module Ayatsuri
	class Operator
		module ActionHelper

			def active_window
				Application::Window.active
			end

			def wait_until_close(subject_window, &block)
				block.call if block
				wait_until { subject_window.not_active? }
			end

			def keys(key, count)
				buf = []
				count.times {|n| buf << key }
				buf
			end

			def input_with_wait(args, interval=0.2)
				args.flatten.each do |arg|
					driver.input arg
					sleep interval
				end
			end
		end
	end
end

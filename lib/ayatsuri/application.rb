require 'ayatsuri/component'

module Ayatsuri
	class Application
		attr_reader :exe_path, :running, :root_window
		alias_method :running?, :running

		def initialize(exe_path)
			@exe_path = exe_path
			@running = false
		end

		def run(operator)
			operator.run(self)
		rescue FailedToRunApplication
		else
			@running = true
		end

		def quit(operator)
			return nil unless self.running?
			operator.quit(self)
		end

		def create_root_window(id, &create_child_block)
			Component.create(:window, nil, id).tap do |root_window|
				if create_child_block
					@root_window = Component.build(root_window, &create_child_block)
				else
					@root_window = root_window
				end
			end
			self
		end
	end
end

module Ayatsuri
	class Operator
		class WindowHistory

			def initialize
				@history = []
			end

			def <<(window)
				@history << window
			end

			def uniq
				all.uniq {|window| window.title }
			end

			def all
				@history
			end
		end
	end
end

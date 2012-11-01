module Ayatsuri
	class Operation
		class Index

			class << self

				def build(&index_block)
					instance_eval(&index_block)
				end

				def window_title(matcher, delegate_method)
				end
			end
		end
	end
end

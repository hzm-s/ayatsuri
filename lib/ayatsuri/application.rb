require 'ayatsuri/application/starter'
require 'ayatsuri/operation/index'

module Ayatsuri
	class Application

		class << self
			attr_reader :starter, :operation_index

			def ayatsuri_for(exe_path, starter_name=:default)
				@starter = Starter.create(exe_path, starter_name)
			end

			def define_operation_index(operation_class, &index_block)
				@operation_index = Operation::Index.build(&index_block)
			end
		end
	end
end

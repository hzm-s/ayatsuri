require 'win32ole'

module Ayatsuri
	class Driver
		autoload :EncodeHelper,	'driver/encode_helper'
		autoload :QueryMethods, 'driver/query_methods'

		include QueryMethods
	end

	class Driver
		@instance = nil

		class << self

			def instance
				@instance ||= new
			end

			def flush
				@instance = nil
			end
		end

		def initialize
			@ole = WIN32OLE.new('AutoItX3.Control')
		end

		private_class_method :new

		def invoke(method, args)
			ole.send(method, *args)
		rescue => e
			raise FailedToOperate, e.message
		end

		def run_application(exe_path)
			invoke(:Run, [exe_path])
		end
	
	protected

		def ole; @ole; end
	end
end

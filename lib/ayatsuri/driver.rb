require 'win32ole'

module Ayatsuri
	class Driver
		autoload :EncodeHelper,			'ayatsuri/driver/encode_helper'
		autoload :ModifierMethods,	'ayatsuri/driver/modifier_methods'
		autoload :QueryMethods, 		'ayatsuri/driver/query_methods'

		include ModifierMethods
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
			after_init
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

		def after_init
			invoke(:AutoItSetOption, ["MouseCoordMode", 0])
		end
	
	protected

		def ole; @ole; end
	end
end

require 'win32ole'
require 'singleton'

module Ayatsuri
	class Driver
		include Singleton

		def initialize
			@ole = WIN32OLE.new('AutoItX3.Control')
		end

		def invoke(method, args)
			ole.send(method, *args)
		rescue => e
			raise FailedToOperate, e.message
		end
	
	protected

		def ole; @ole; end
	end
end

module Ayatsuri
	class Driver
		module EncodeHelper

			def encode_for_driver(obj)
				encode_to(Encoding::WINDOWS_31J, obj)
			end

			def encode_for_ayatsuri(obj)
				encode_to(Encoding::UTF_8, obj)
			end

			def encode_to(encoding, obj)
				return obj.collect {|o| encode_to(encoding, o) } if obj.respond_to?(:collect)
				return obj.encode(encoding) if obj.respond_to?(:encode)
				obj
			end
		end
	end
end

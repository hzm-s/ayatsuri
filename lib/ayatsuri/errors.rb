module Ayatsuri
	class AyatsuriError < StandardError
	end

	class UnavailableComponentType < AyatsuriError
	end

	class FailedToBootApplication < AyatsuriError
	end

	class OperationNotImplement < AyatsuriError
		attr_reader :adapter_class, :operate_method

		def initialize(adapter_class, operate_method)
			@adapter_class, @operate_method = adapter_class, operate_method
		end

		def message
			"Not implemented `#{operate_method}` on #{adapter_class}"
		end
	end

	class FailedToOperate < AyatsuriError
	end
end

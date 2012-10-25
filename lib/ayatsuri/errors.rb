module Ayatsuri
	class AyatsuriError < StandardError
	end

	class UnavailableComponentType < AyatsuriError
	end

	class FailedToRunApplication < AyatsuriError
	end

	class FailedToQuitApplication < AyatsuriError
	end

	class ApplicationNotRunning < AyatsuriError
	end

	class FailedToOperate < AyatsuriError
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
end

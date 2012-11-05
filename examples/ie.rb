#encoding:utf-8

require 'ayatsuri'

Ayatsuri::Interval.application_monitor = 2

class IEOperator < Ayatsuri::Operator

	def skip_setup
		input "!a"
	end

	def input_keyword
		input "{TAB 2}"
		input params[:keyword]
		input "{ENTER}"
	end

	def invoke_save
		input "!fa"
	end

	def save_file
		input "{TAB}{DOWN 2}{ENTER}+{TAB}"
		input params[:save_path].gsub(/\//, "\\")
		input "{ENTER}"
	end

	def overwrite
		wait_until_close_window { input "!y" }
	end
end

class IE < Ayatsuri::Application
	ayatsuri_for 'iexplore', :ProgramManager

	define_operation_order IEOperator do
		window_title /設定/,				:skip_setup,	:optional
		window_title /^空白の/,			:input_keyword
		window_title /\- .+ \-/,		:invoke_save
		window_title /保存/,				:save_file
		window_title /保存/,				:overwrite,		:optional
		window_title /\- .+ \-/,		:complete
	end

	def save_search_result(keyword, save_path)
		run(keyword: keyword, save_path: save_path)
		save_path
	end
end


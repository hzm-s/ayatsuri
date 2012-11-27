#encoding:utf-8

require 'ayatsuri'

Ayatsuri::Interval.application_monitor = 2
Ayatsuri::Operation.wait_next_operation_limit = 60

class IEOperator < Ayatsuri::Operator

	def skip_setup
		sleep 5
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
		input "!y"
	end
end

class IE < Ayatsuri::Application
	ayatsuri_for 'iexplore', :ProgramManager

	define_operation_order IEOperator do
		operate(:input_keyword) 			{ active_window.title =~ /^空白の/ }
		operate(:invoke_save)					{ active_window.title =~ /\- .+ \-/ }
		operate(:save_file)						{ active_window.title =~ /保存/}
		operate(:overwrite,	limit: 3)	{ active_window.content =~ /上書き/ }
		operate(:complete)						{ active_window.title =~ /\- .+ \-/ }
	end

	def save_search_result(keyword, save_path)
		run(keyword: keyword, save_path: save_path)
		save_path
	end
end


#encoding:utf-8

require 'ayatsuri'

class FirefoxOperator < Ayatsuri::Operator

	def skip_setup
		"skip"
	end

	def input_keyword
		press("^k").
		input(params[:keyword])
		press("{ENTER}")
	end

	def invoke_save
		press("!s")
	end

	def save_file
		input(save_path)
		press("{TAB}{DOWN 2}{ENTER}")
	end

	def quit
		quit_application
	end
end

class Firefox < Ayatsuri::Application
	ayatsuri_for 'C:\Program Files\Mozilla Firefox\firefox.exe'

	define_operation_order FirefoxOperator do
		window_title /Setup/,		:skip_setup,		:optional
		window_title /Firefox/, :input_keyword
		window_title /検\索/,		:invoke_save
		window_title /保存/,		:save_file
		window_title /検\索/,		:quit
	end

	def save_search_result(keyword, save_path)
		run(keyword: keyword, save_path: save_path)
	end
end


#encoding:utf-8

require 'ayatsuri'

class FirefoxOperator < Ayatsuri::Operator

	def skip_setup
		invoke(:Send, ["!n"])
	end

	def input_keyword
		press("^k")
		input(params[:keyword])
		press("{ENTER}")
	end

	def invoke_save
		press("!s")
	end

	def save_file
		input(save_path)
		press("{TAB}{DOWN 2}{ENTER}")

		complete!
	end
end

class Firefox < Ayatsuri::Application
	ayatsuri_for 'firefox', :clickonce

	define_operation_order FirefoxOperator do
		window_title /制御$/,		:skip_setup,		:optional
		window_title /Firefox/, :input_keyword
		window_title /検索/,		:invoke_save
		window_title /保存/,		:save_file
	end

	def save_search_result(keyword, save_path)
		run(keyword: keyword, save_path: save_path)
	end
end


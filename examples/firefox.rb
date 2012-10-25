#encoding:utf-8

require 'ayatsuri'

class Firefox < Ayatsuri::Base
	ayatsuri_for 'C:\Program Files\Mozilla Firefox\firefox.exe'

	def save_search_result(keyword, save_path)
		operate do
			on window_title: /Firefox/ do
				press_ctrl_k.
				input(keyword).and_enter
			end

			on window_title: /検索/ do
				press_ctrl_s
			end

			on :new_window do
				input(save_path).
					press_tab.
					press_down(2).and_enter.
					press_enter
			end
		end
	end
end

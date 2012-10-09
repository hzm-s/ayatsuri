#encoding:utf-8

class Calc < Ayatsuri::Application
	ayatsuri_for "calc.exe", title: "電卓"
	has_textbox "result", id: 99
	has_button "1", id: 1
	has_button "2", id: 2
	has_button "3", id: 3
	has_button "4", id: 4
	has_button "5", id: 5
	has_button "6", id: 6
	has_button "7", id: 7
	has_button "8", id: 8
	has_button "9", id: 9
	has_button "0", id: 0
	has_button "+", id: 99
	has_button "-", id: 99
	has_button "*", id: 99
	has_button "/", id: 99
	has_button "=", id: 99

	def calculate(expression)
		expression.split(/\s+/).each do |value|
			button(value).click
		end
		button("=").click
		textbox("result").text.to_i
	end
end

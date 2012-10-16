#encoding:utf-8

class Calc < Ayatsuri::Application
	ayatsuri_for "calc.exe", "電卓" do
		label "result", id: 99
		button "1", id: 1
		button "2", id: 2
		button "3", id: 3
		button "4", id: 4
		button "5", id: 5
		button "6", id: 6
		button "7", id: 7
		button "8", id: 8
		button "9", id: 9
		button "0", id: 0
		button "+", id: 99
		button "-", id: 99
		button "*", id: 99
		button "/", id: 99
		button "=", id: 99
	end

	def calculate(expression)
		boot do
			expression.split(/\s+/).each do |value|
				button(value).click
			end
			button("=").click
			label("result").text.to_i
		end
	end
end

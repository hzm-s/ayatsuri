#encoding:utf-8

class Calc < Ayatsuri::Base
	ayatsuri_for "calc.exe", "電卓" do
		label "result", 403
		button "c", 81
		button "0", 124
		button "1", 125
		button "2", 126
		button "3", 127
		button "4", 128
		button "5", 129
		button "6", 130
		button "7", 131
		button "8", 132
		button "9", 133
		button "+", 92
		button "-", 93
		button "*", 91
		button "/", 90
		button "=", 112
	end

	def calculate(expression)
		boot! do
			expression.split(/\s+/).each do |value|
				button(value).click
			end
			button("=").click
			label("result").content.sub(/\s\.$/, '')
		end
	end
end

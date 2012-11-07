module Ayatsuri
	class Application
		class TreeView < ControlBase

			def select(item_no)
				driver.select_tree_view_item(window.title, id, item_no)
			end
		end
	end
end

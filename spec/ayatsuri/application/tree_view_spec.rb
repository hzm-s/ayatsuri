require 'spec_helper'

module Ayatsuri
	class Application
		describe TreeView do
			include_context "application_control"

			let(:model) { described_class.new window, control_id }

			describe "#select" do
				subject { model.select item_no }

				let(:item_no) { 5 }

				before do
					driver.stub(:select_tree_view_item).with(window_title, control_id, item_no) { true }
				end
				it { should be_true }
			end
		end
	end
end

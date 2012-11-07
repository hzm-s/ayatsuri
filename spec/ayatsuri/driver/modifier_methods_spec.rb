require 'spec_helper'

module Ayatsuri
	class Driver
		describe ModifierMethods do
			let(:model) { Object.new.extend(described_class) }

			before do
				model.stub(:modify).with(*modify_args) { result }
			end

			let(:result) { mock 'result from driver' }
			let(:window_title) { mock 'window title' }
			let(:control_id) { mock 'control id' }

			describe "#close_window" do
				subject { model.close_window window_title }

				let(:modify_args) { [:WinClose, [window_title]] }

				it { should == result }
			end

			describe "#focus_control" do
				subject { model.focus_control window_title, control_id }

				let(:modify_args) { [:ControlFocus, [window_title, "", control_id]] }

				it { should == result }
			end

			describe "#click_control" do
				subject { model.click_control window_title, control_id }

				let(:modify_args) { [:ControlClick, [window_title, "", control_id]] }

				it { should == result }
			end

			describe "#set_text_to_control" do
				subject { model.set_text_to_control window_title, control_id, text }

				let(:text) { "a text to set control" }
				let(:modify_args) { [:ControlSetText, [window_title, "", control_id, text]] }

				it { should == result }
			end

			describe "#select_tree_view_item" do
				subject { model.select_tree_view_item window_title, control_id, item_no }

				let(:item_no) { 5 }
				let(:modify_args) { [:ControlTreeView, [window_title, "", control_id, "Select", "##{item_no}", ""]] }

				it { should == result }
			end
		end
	end
end

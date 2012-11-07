require 'spec_helper'

module Ayatsuri
	class Application
		describe Control do
			include_context "application_control"

			let(:model) { described_class.new window, control_id }

			describe "#enabled?" do
				subject { model.enabled? }
				before do
					driver.stub(:control_enabled?).with(window_title, control_id) { true }
				end
				it { should be_true }
			end

			describe "#not_enabled?" do
				subject { model.not_enabled? }
				before do
					driver.stub(:control_enabled?).with(window_title, control_id) { false }
				end
				it { should be_true }
			end

			describe "#text" do
				subject { model.text }
				before do
					driver.stub(:get_control_text).with(window_title, control_id) { "control text" }
				end
				it { should == "control text" }
			end

			describe "#focus" do
				subject { model.focus }
				before do
					driver.stub(:focus_control).with(window_title, control_id) { true }
				end
				it { should be_true }
			end

			describe "#click" do
				subject { model.click }
				before do
					driver.stub(:click_control).with(window_title, control_id) { true }
				end
				it { should be_true }
			end

			describe "#text=" do
				subject { model.text = text }
				let(:text) { "a text to set control" }
				before do
					driver.stub(:set_text_to_control).with(window_title, control_id, text) { true }
				end
				it { should be_true }
			end
		end
	end
end

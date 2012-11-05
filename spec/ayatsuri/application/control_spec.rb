require 'spec_helper'

module Ayatsuri
	class Application
		describe Control do
			let(:model) { described_class.new window, control_id }

			let(:window) do
				double('window').tap do |d|
					d.stub(:driver) { driver }
					d.stub(:title) { window_title }
				end
			end

			let(:driver) { mock 'driver instance' }
			let(:window_title) { mock 'window title' }
			let(:control_id) { mock 'control id' }

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

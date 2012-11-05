require 'spec_helper'

module Ayatsuri
	class Application
		describe Window do
			before { Driver.stub(:instance) { driver } }

			let(:driver) { mock 'Driver instance' }
			let(:handle) { mock 'active window handle' }
			let(:title) { mock 'active window title' }

			describe ".active" do
				subject { described_class.active }

				before do
					driver.stub(:get_active_window_handle) { handle }
					driver.stub(:get_active_window_title) { title }
					described_class.stub(:new).with(driver, handle, title) { active_window }
				end

				let(:active_window) { mock 'active window' }

				it { should == active_window }
			end

			let(:model) { described_class.new driver, handle, title }

			describe ".new" do
				subject { model }
				it { subject.driver == driver }
				it { subject.handle == handle }
				it { subject.title == title }
			end

			describe "#text" do
				subject { model.text }
				before { driver.stub(:get_window_text).with(title) { "text" } }
				it { should == "text" }
			end

			describe "#active?" do
				subject { model.active? }
				before { driver.stub(:window_active?).with(title) { true } }
				it { should be_true }
			end

			describe "#not_active?" do
				subject { model.not_active? }
				before { driver.stub(:window_active?).with(title) { true } }
				it { should be_false }
			end

			describe "#exist?" do
				subject { model.exist? }
				before { driver.stub(:window_exist?).with(title) { true } }
				it { should be_true }
			end

			describe "#not_exist?" do
				subject { model.not_exist? }
				before { driver.stub(:window_exist?).with(title) { true } }
				it { should be_false }
			end

			describe "#control" do
				subject { model.control control_id }

				let(:control_id) { mock 'control id' }

				before { Control.stub(:new).with(model, control_id) { control } }

				let(:control) { mock 'control' }

				it { should == control }
			end

			describe "#==" do
				subject { model == other }

				context "when equal" do
					let(:other) { described_class.new driver, handle, title }
					it { should be_true }
				end

				context "when NOT equal" do
					context "given different handle" do
						let(:other) { described_class.new driver, :other_handle, title }
						it { should be_false }
					end

					context "given different title" do
						let(:other) { described_class.new driver, handle, 'other window title' }
						it { should be_false }
					end

					context "given other instance of class" do
						let(:other) do
							Object.new.tap do |obj|
								obj.stub(:handle).and_return(handle)
								obj.stub(:title).and_return(title)
							end
						end
						it { should be_false }
					end
				end
			end
		end
	end
end

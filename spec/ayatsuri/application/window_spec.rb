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
					described_class.stub(:new).with(handle, title) { active_window }
				end

				let(:active_window) { mock 'active window' }

				it { should == active_window }
			end

			let(:model) { described_class.new handle, title }

			describe ".new" do
				subject { model }
				it { subject.handle == handle }
				it { subject.title == title }
			end

			describe "#==" do
				subject { model == other }

				context "when equal" do
					let(:other) { described_class.new handle, title }
					it { should be_true }
				end

				context "when NOT equal" do
					context "given different handle" do
						let(:other) { described_class.new :other_handle, title }
						it { should be_false }
					end

					context "given different title" do
						let(:other) { described_class.new handle, 'other window title' }
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

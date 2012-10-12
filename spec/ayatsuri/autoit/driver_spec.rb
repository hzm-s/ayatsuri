require 'spec_helper'

module Ayatsuri
	module AutoIt
		describe Driver do
			let(:model) { described_class.create exe }

			let(:exe) { "application.exe" }

			describe ".create" do
				subject { described_class.create exe }

				it { should == described_class.create(exe) }
				it { should_not == described_class.create("otherapp.exe") }
			end

			describe ".new" do
				subject { described_class.new mock('win32com'), exe }
				it { expect { subject }.to raise_error(NoMethodError) }
			end

			describe "#boot_application" do
				subject { model.boot_application }

				it "calls Run with exe to Win32COM" do
					WIN32OLE.any_instance.should_receive(:Run)
					subject
				end
			end

			describe "#activate_window" do
				subject { model.activate_window window }

				let(:window) { mock 'window' }
				let(:window_title) { mock 'window_title' }

				before do
					window.should_receive(:title).and_return(window_title)
				end

				it "calls WinWaitActive with window.title to win32com" do
					WIN32OLE.any_instance.should_receive(:WinWaitActive).with(window_title)
					subject
				end
			end

			describe "handle application" do
				let(:window) { mock 'window' }
				let(:control) { mock 'control' }

				before do
					model.should_receive(:boot_application)
					window.should_receive(:activate)
					window.stub(:title).and_return(window_title)
					control.stub(:id).and_return(control_id)
				end

				let(:window_title) { mock "a window title" }
				let(:control_id) { mock "control id" }

				describe "#click" do
					subject { model.click window, control }

					it "calls ControlClick to win32com" do
						WIN32OLE.any_instance.should_receive(:ControlClick).
							with(window_title, "", control_id)
						subject
					end
				end
			end
		end
	end
end

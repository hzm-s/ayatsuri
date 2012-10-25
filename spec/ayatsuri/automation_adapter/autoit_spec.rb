require 'spec_helper'

module Ayatsuri
	module AutomationAdapter
		describe Autoit do
			let(:model) { described_class.new }

			before do
				WIN32OLE.stub(:new).with('AutoItX3.Control').and_return(com)
			end

			let(:com) { mock 'win32ole com for autoit' }

			describe ".new" do
				subject { model }

				it "creates Win32OLE com object for AutoItX3.Control" do
					WIN32OLE.should_receive(:new).with('AutoItX3.Control').and_return(com)
					subject
				end
			end

			describe "#create_window_identifier" do
				subject { model.create_window_identifier id }

				let(:id) { "window identifier" }
				let(:encoded_id) { mock 'encoded window identifier' }

				it "encodes given identifier to WINDOWS-31J" do
					id.should_receive(:encode).with(Encoding::Windows_31J).and_return(encoded_id)
					subject.should == encoded_id
				end
			end

			describe "#run" do
				subject { model.run exe_path }
				
				let(:exe_path) { 'C:\Program Files\application.exe' }

				it "calls Run to com" do
					com.should_receive(:Run).with(exe_path)
					subject
				end
			end

			describe "#shutdown!" do
				subject { model.shutdown! root_window }

				let(:root_window) { double('root window').tap {|d| d.stub(:identifier) { id } } }
				let(:id) { mock "root window identifier" }

				it "calls WinClose to com" do
					com.should_receive(:WinClose).with(id)
					subject
				end
			end

			describe "operate window or control" do
				let(:window) do
					double('window').tap {|d| d.stub(:identifier) { window_id } }
				end

				let(:window_id) { mock "window identifier" }

				let(:control) do
					double('control').tap do |d|
						d.stub(:parent_identifier) { parent_id }
						d.stub(:identifier) { id }
					end
				end

				let(:parent_id) { mock 'parent identifier' }
				let(:id) { mock 'control identifier' }

				describe "#activate" do
					subject { model.activate window }

					it "calls WinActivate to com" do
						com.should_receive(:WinActivate).with(window_id)
						subject
					end
				end

				describe "#click" do
					subject { model.click control }

					it "calls ControlClick to com" do
						com.should_receive(:ControlClick).with(parent_id, "", id)
						subject
					end
				end

				describe "#get_content" do
					subject { model.get_content control }

					it "calls ControlGetText to com" do
						com.should_receive(:ControlGetText).with(parent_id, "", id)
						subject
					end
				end
			end
		end
	end
end

require 'spec_helper'

module Ayatsuri
	module AutomationAdapter
		describe Autoit do
		end
	end
end
__END__
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

			describe "#run" do
				subject { model.run exe_path }
				
				let(:exe_path) { 'C:\Program Files\application.exe' }

				it "calls Run to com" do
					com.should_receive(:Run).with(exe_path)
					subject
				end
			end

			describe "#booted?" do
				subject { model.booted? }

				context "when booted" do
					it { should be_true }
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
		end
	end
end

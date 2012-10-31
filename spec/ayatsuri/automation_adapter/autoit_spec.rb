require 'spec_helper'

module Ayatsuri
	module AutomationAdapter
		describe Autoit do
			let(:model) { described_class.new }

			before do
				WIN32OLE.stub(:new).with('AutoItX3.Control').and_return(ole)
			end

			let(:ole) { mock 'win32ole for autoit' }

			describe "#run_application" do
				subject { model.run_application exe_path }

				let(:exe_path) { "/path/to/application.exe" }
				before { ole.should_receive(:Run).with(exe_path) }
				it { should be_true }
			end

			describe "#input" do
				subject { model.input keys }

				context "given string" do
					let(:keys) { "input" }

					before { ole.should_receive(:Send).with(keys) }
					it { should be_true }
				end

				context "given symbol" do
					let(:keys) { :win_r }

					before { ole.should_receive(:Send).with("#r") }
					it { should be_true }
				end
			end
		end
	end
end

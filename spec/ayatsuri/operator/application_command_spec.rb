require 'spec_helper'

module Ayatsuri
	class Operator
		describe ApplicationCommand do
			include_context "operator_feature"

			let(:application) do
				double('application').tap do |d|
					d.stub(:exe_path) { exe_path }
				end
			end

			let(:exe_path) { 'C:\Program Files\application.exe' }

			describe "#run" do
				subject { operator.run application }

				before do
					operator.stub(:invoke).with(:run, exe_path) { return_value }
				end

				it { should == return_value }
			end

			describe "#quit" do
				subject { operator.quit application }

				before do
					application.stub(:opened_windows).and_return(opened_windows)
					operator.stub(:invoke).with(:close_active_window, opened_windows.size).
						and_return(return_value)
				end

				let(:opened_windows) { [mock('window1'), mock('window2')] }

				it { should == return_value }
			end
		end
	end
end

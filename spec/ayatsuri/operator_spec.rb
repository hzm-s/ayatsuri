require 'spec_helper'

module Ayatsuri
	describe Operator do
		let(:model) { described_class.new param_hash }

		let(:param_hash) { mock 'paramter hash' }

		describe ".new" do
			subject { model }
			it { subject.driver.should == Driver.instance }
			it { subject.params.should == param_hash }
		end

		describe "#assign" do
			subject { model.assign operation }

			let(:operation) { mock 'operation' }

			before do
				operation.stub(:method_name) { :operate_method }
			end

			it "calls operation.method_name to self" do
				model.should_receive(:log_window_history).ordered
				model.should_receive(operation.method_name).ordered
				subject
			end
		end

		describe "#log_window_history" do
			subject { model.log_window_history }

			before do
				model.stub(:active_window) { window }
				model.stub(:window_history) { history }
				history.stub(:log).with(window) { window }
			end

			let(:window) { mock 'window' }
			let(:history) { mock 'window history' }

			it { should == window }
		end

		describe "#complete!" do
			subject { model.complete! }

			before { model.stub(:quit_application) }

			it { subject.completed?.should be_true }

			describe "#completed?" do
				subject { model.completed? }

				context "when completed" do
					before { model.complete! }
					it { should be_true }
				end

				context "when NOT completed" do
					it { should be_false }
				end
			end
		end
	end
end

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
			subject { model.assign operation, window }

			let(:operation) { mock 'operation' }
			let(:window) { mock 'window' }

			before do
				model.stub(:window_history) { window_history }
				operation.stub(:method_name) { :operate_method }
			end

			let(:window_history) { mock 'window history' }

			it "calls operation.method_name to self" do
				window_history.should_receive(:<<).with(window)
				model.should_receive(operation.method_name)
				subject
			end
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

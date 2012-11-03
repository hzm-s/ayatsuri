require 'spec_helper'

module Ayatsuri
	describe Operator do
		let(:model) { described_class.new operation_order, param_hash }

		let(:operation_order) { mock 'operation order' }
		let(:param_hash) { mock 'paramter hash' }

		describe ".new" do
			subject { model }

			it { subject.operation_order.should == operation_order }
			it { subject.params.should == param_hash }
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

		describe "#quit_application" do
			subject { model.quit_application }

			before do
				model.stub(:close_all_opened_window) { true }
			end

			it { should be_true }
		end
	end
end

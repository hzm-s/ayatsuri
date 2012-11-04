require 'spec_helper'

module Ayatsuri
	describe Operation do
		let(:model) { described_class.new condition, method_name, optional }

		let(:condition) { mock 'condition' }
		let(:method_name) { :operation_method }
		let(:optional) { mock 'optional operation flag' }

		describe ".new" do
			subject { model }
			it { subject.method_name.should == method_name }
			it { subject.optional?.should == optional }
		end

		describe "#assigned?" do
			subject { model.assigned? window }

			let(:window) { mock 'dispatched window' }

			before do
				condition.stub(:satisfy?).with(window) { assigned }
			end

			context "when assigned" do
				let(:assigned) { true }
				it { should be_true }
			end

			context "when NOT assigned" do
				let(:assigned) { false }
				it { should be_false }
			end
		end
	end
end

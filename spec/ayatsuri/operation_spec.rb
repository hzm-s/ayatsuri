require 'spec_helper'

module Ayatsuri
	describe Operation do
		let(:model) { described_class.new condition, method_name, optional }

		let(:condition) { mock 'condition' }
		let(:method_name) { :operation_method }
		let(:optional) { mock 'operation attribute' }

		describe ".new" do
			subject { model }

			it { subject.condition.should == condition }
			it { subject.method_name.should == method_name }
			it { subject.optional?.should == optional }
		end
	end
end

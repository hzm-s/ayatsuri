require 'spec_helper'

module Ayatsuri
	describe Operation do
		let(:model) { described_class.new condition, &block }

		let(:condition) { mock 'condition' }
		let(:block) { lambda { "operation block" } }

		describe ".new" do
			subject { model }

			it { subject.condition.should == condition }
			it { subject.operation_block.should == block }
		end
	end
end

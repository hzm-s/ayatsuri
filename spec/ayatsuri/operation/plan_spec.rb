require 'spec_helper'

module Ayatsuri
	class Operation
		describe Plan do
			describe ".create" do
				subject { described_class.create &plan_block }

				let(:plan_block) { lambda { "operation plan" } }

				before do
					stub_const("Ayatsuri::Operation::Builder", Class.new)
					Builder.stub(:build).with(&plan_block).and_return(operations)
					described_class.stub(:new).with(operations).and_return(plan)
				end

				let(:operations) { mock 'operations' }
				let(:plan) { mock 'plan' }

				it { should == plan }
			end

			let(:model) { described_class.new operations }
		end
	end
end

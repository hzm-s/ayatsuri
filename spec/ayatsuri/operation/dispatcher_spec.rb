require 'spec_helper'

module Ayatsuri
	class Operation
		describe Dispatcher do
			let(:model) { described_class.new operator, order }
	
			let(:operator) { mock 'operator' }
			let(:order) { mock 'operation order' }
	
			let(:operation) { mock 'operation' }
	
			describe "#start" do
				subject { model.start }
	
				before do
					operator.stub(:completed?).and_return(false, false, false, true)
					order.stub(:next).and_return(operation)
					model.stub(:dispatch).with(operation)
				end
	
				it { should == order }
			end
			
			describe "#dispatch" do
				subject { model.dispatch operation }

				before do
					operation.stub(:decide).with(operator) { decision }
				end

				let(:decision) { mock 'operation decision' }

				it "accepts decision" do
					decision.should_receive(:perform).with(operator)
					subject
				end
			end
		end
	end
end

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
	
				context "when all operations are complete" do
					before do
						operator.stub(:completed?).and_return(false, false, false, true)
						order.stub(:next).and_return(operation)
						operator.stub(:assign).with(operation)
					end
	
					it { should == order }
				end

				context "when empty order before operator completed" do
					before do
						operator.stub(:completed?).and_return(false, false, true)
						order.stub(:next).and_raise(ex)
					end

					let(:ex) { Ayatsuri::NothingNextOperation }

					it { expect { subject }.to raise_error(ex) }
				end
			end
		end
	end
end

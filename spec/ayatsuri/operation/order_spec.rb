module Ayatsuri
	class Operation
		describe Order do
			let(:operations) { mock 'operations' }

			describe ".create" do
				subject { described_class.create &operation_block }

				let(:operation_block) { lambda { "operations" } }

				before do
					Operation::Builder.stub(:build).with(&operation_block).and_return(operations)
					described_class.stub(:new).with(operations) { order }
				end

				let(:order) { mock 'operation order' }

				it { should == order }
			end

			let(:model) { described_class.new operations }

		end
	end
end

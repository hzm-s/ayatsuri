require 'spec_helper'

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

			describe "#retrieve" do
				subject { model.retrieve window }

				let(:window) { mock 'window' }

				before do
					model.stub(:next_operation) { next_operation }
					next_operation.stub(:assigned?) { assigned }
					next_operation.stub(:optional?) { optional }
				end

				let(:next_operation) { mock 'next operation' }

				context "when assigned" do
					let(:assigned) { true }
					let(:optional) { false }
					it { should == next_operation }
				end

				context "when NOT assigned" do
					context "when operation is optional" do
						before do
							model.stub(:next_operation).and_return(primary, secondary)
						end

						let(:primary) do
							double('primary').tap {|d|
								d.stub(:assigned?) { false }
								d.stub(:optional?) { true }
							}
						end

						let(:secondary) do
							double('secondary').tap {|d|
								d.stub(:assigned?) { true }
							}
						end

						it { should == secondary }
					end

					context "when operation is NOT optional" do
						let(:assigned) { false }
						let(:optional) { false }
						it { should be_instance_of(Operation::Unassigned) }
					end
				end
			end

			describe "#next" do
				before { @model = described_class.new [:op1, :op2, :op3] }

				it "iterates given operations" do
					@model.next.should == :op1
					@model.next.should == :op2
					@model.next.should == :op3
					expect { @model.next }.to raise_error(Ayatsuri::NothingNextOperation)
				end
			end
		end
	end
end

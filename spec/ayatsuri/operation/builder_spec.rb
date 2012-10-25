require 'spec_helper'

module Ayatsuri
	class Operation
		describe Builder do
			describe ".build" do
				subject { described_class.build &plan_block }

				let(:plan_block) { lambda { "plan block" } }

				before do
					described_class.stub(:new).and_return(builder)
					builder.stub(:instance_eval).with(&plan_block).and_return(builder)
					builder.stub(:operations).and_return(operations)
				end

				let(:builder) { mock 'builder' }
				let(:operations) { mock 'operations' }

				it { should == operations }
			end

			let(:model) { described_class.new }

			describe "when constructed" do

				describe "#on" do
					subject { model.on condition_spec &operation_block }

					let(:condition_spec) { mock 'condition spec' }
					let(:operation_block) { lambda { "operation block" } }

					before do
						@operations = []
						model.tap do |model|
							model.stub(:add_operation) {|op| @operations << op }
							model.stub(:operations) { @operations }
						end
					end

					before do
						stub_const("Ayatsuri::Operation", Class.new)
						stub_const("Ayatsuri::Operation::Condition", Class.new)
						Operation::Condition.stub(:create).with(condition_spec).and_return(condition)
						Operation.stub(:new).with(condition, &operation_block).and_return(operation)
					end

					let(:condition) { mock 'to begin operating condition' }
					let(:operation) { mock 'ayatsuri operation' }

					it { subject.operations.should == [operation] }
				end

				describe "#add_operation" do
					subject { model.add_operation operation }
					let(:operation) { mock 'operation' }
					before { subject }
					it { model.operations.should == [operation] }
				end
			end
		end
	end
end

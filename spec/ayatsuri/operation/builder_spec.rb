require 'spec_helper'

module Ayatsuri
	class Operation
		describe Builder do
			describe ".build" do
				subject { described_class.build &order_block }

				let(:order_block) { lambda { "operations" } }

				before do
					described_class.stub(:new).and_return(builder)
					builder.stub(:instance_eval).with(&order_block).and_return(builder)
					builder.stub(:operations).and_return(operations)
				end

				let(:builder) { mock 'builder' }
				let(:operations) { mock 'operations' }

				it { should == operations }
			end

			let(:model) { described_class.new }

			describe "when constructed" do

				describe "#operate" do
					subject { model.operate method_name, if_flag, &condition_block }

					let(:method_name) { :method_name_for_operator }
					let(:if_flag) { mock ('if flag') }
					let(:condition_block) { lambda { "condition matcher" } }
						
					before do
						Condition.stub(:new).with(&condition_block).and_return(condition)
						Operation.stub(:new).with(condition, method_name, if_flag) { operation }
						model.stub(:add_operation).with(operation) { operation }
					end

					let(:condition) { mock 'condition' }
					let(:operation) { mock 'operation' }

					it { should == operation }
				end

				describe "#window_title" do
					subject { model.window_title expect, method_name, optional }

					let(:expect) { mock 'expect window condition' }
					let(:method_name) { :operate_method }
					let(:optional) { mock 'optional flag' }

					before do
						Condition.stub(:create).with(:title, expect) { condition }
						Operation.stub(:new).with(condition, method_name, optional) { operation }
						model.stub(:add_operation).with(operation) { operation }
					end

					let(:condition) { mock 'window condition' }
					let(:operation) { mock 'ayatsuri operation' }

					it { should == operation }
				end

				describe "#add_operation" do
					subject { model.add_operation operation }
					let(:operation) { mock 'operation' }
					it { subject; model.operations.should == [operation] }
				end
			end
		end
	end
end

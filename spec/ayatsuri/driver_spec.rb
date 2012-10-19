require 'spec_helper'

module Ayatsuri
	describe Driver do
		let(:model) { described_class.create adapter_name }

		let(:adapter_name) { "fake" }

		let(:adapter_class) { AutomationAdapter::Fake }
		let(:adapter) { mock 'automation adapter' }

		before do
			stub_const("Ayatsuri::AutomationAdapter::Fake", Class.new)
			adapter_class.stub(:new).and_return(adapter)
		end

		after { described_class.flush }

		describe ".create" do
			subject { model }

			it "creates adapter for given automation adapter name" do
				subject.adapter.should == adapter
			end

			context "when create twice" do
				context "when create again" do
					it { subject.should == described_class.create(adapter_name) }
				end

				context "when create for other app" do
					before do
						stub_const("Ayatsuri::AutomationAdapter::Fake2", Class.new)
					end

					it { subject.should_not == described_class.create("fake2") }
				end
			end
		end

		describe ".new" do
			subject { described_class.new "fake" }
			it { expect { subject }.to raise_error(NoMethodError) }
		end

		describe "operate via driver" do
			subject { model.send(operate_method, args, &block) }

			let(:operate_method) { :operate }
			let(:args) { mock 'arguments for operate' }
			let(:block) { Proc.new { "operate method block" } }

			before do
				adapter.should_receive(:respond_to?).with(operate_method).and_return(respond_to)
			end

			context "when known operation" do
				let(:respond_to) { true }

				let(:stub_adapter_operate) do
					adapter.should_receive(:send).with(operate_method, args, &block)
				end

				context "when successful" do
					before { stub_adapter_operate.and_return(true) }

					it { should be_true }
				end

				context "when failed" do
					let(:ex) { FailedToOperate }

					before { stub_adapter_operate.and_raise(ex) }

					it { expect { subject }.to raise_error(ex) }
				end
			end

			context "when unknown operation" do
				let(:respond_to) { false }
				it { expect { subject }.to raise_error(OperationNotImplement) }
			end
		end
	end
end

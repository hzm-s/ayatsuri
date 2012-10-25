require 'spec_helper'

module Ayatsuri
	describe Operator do
		let(:model) { described_class.new driver, application }

		before do
			stub_const("Ayatsuri::ErrorInPerform", StandardError.new)
		end

		let(:driver) { mock 'driver' }
		let(:application) { mock 'application' }

		describe "#perform" do
			subject { model.perform plan }

			let(:plan) { mock 'operation plan' }

			before do
				model.stub(:run_application) { true }
				model.stub(:operate).with(plan) { true }
				model.should_receive(:quit_application) { true }
			end

			context "when successful" do
				it { should be_true }
			end

			context "when any exception in process" do
				before do
					model.stub(:operate).with(plan) { raise exception }
				end
				let(:exception) { ErrorInPerform }
				it { expect { subject }.to raise_error(exception) }
			end
		end

		describe "handle application" do
			shared_examples "handle_application" do |method, exception|
				let(:stub_application) { application.stub(method).with(model) }

				context "when successful" do
					before { stub_application.and_return(true) }
					it { should be_true }
				end

				context "when fail" do
					before { stub_application.and_raise(exception) }
					it { expect { subject }.to raise_error(exception) }
				end
			end

			describe "#run_application" do
				subject { model.run_application }
				it_behaves_like "handle_application", :run, FailedToRunApplication
			end

			describe "#quit_application" do
				subject { model.quit_application }
				it_behaves_like "handle_application", :quit, FailedToQuitApplication
			end
		end

		describe "#invoke" do
			subject { model.invoke method, args }
			
			let(:method) { :action }
			let(:args) { mock 'args' }

			before do
				driver.stub(method).with(args) { return_value }
			end

			let(:return_value) { mock 'return value from adapter method' }

			it { should == return_value }
		end

		describe "#operate" do
			subject { model.operate plan }

			let(:plan) { mock 'operate plan' }
			let(:operate_block) { lambda { "operate block" } }

			let(:stub_plan) { plan.stub(:each_operation) }

			before do
				stub_plan.with(&operate_block).and_return(true)
			end
			it { should be_true }
		end
	end
end

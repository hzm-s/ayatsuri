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

		describe "#run_application" do
			subject { model.run_application }
			before { application.stub(:run) { true } }
			it { should be_true }
		end

		describe "#quit_application" do
			subject { model.quit_application }
			before { application.stub(:quit) { true } }
			it { should be_true }
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

require 'spec_helper'

module Ayatsuri
	describe Base do
		let(:klass) { described_class }

		describe ".ayatsuri_for" do
			subject { klass.ayatsuri_for automation_adapter, exe_path }

			let(:automation_adapter) { :autoit }
			let(:exe_path) { 'C:\Program Files\app.exe' }

			before do
				Driver.stub(:create).with(automation_adapter) { driver }
				Application.stub(:new).with(driver, exe_path) { application }
			end

			let(:driver) { mock 'ayatsuri driver' }
			let(:application) { mock 'application' }

			it { subject.driver.should == driver }
			it { subject.application.should == application }
		end

		context "when constructed" do
			let(:model) { klass.new }

			before do
				klass.stub(:driver).and_return(driver)
				klass.stub(:application).and_return(application)
				Operator.stub(:new).with(driver, application).and_return(operator)
			end

			let(:driver) { mock 'driver' }
			let(:application) { mock 'application' }
			let(:operator) { mock 'operator' }

			describe ".new" do
				subject { model }
				it { subject.operator.should == operator }
			end

			describe "#operate" do
				subject { model.operate &plan_block }

				let(:plan_block) { lambda { "plan block" } }

				before do
					Operation::Plan.stub(:create).with(&plan_block).and_return(plan)
					operator.stub(:perform).with(plan).and_return(true)
				end

				let(:plan) { mock 'operate plan' }

				it { should be_true }
			end
		end
	end
end

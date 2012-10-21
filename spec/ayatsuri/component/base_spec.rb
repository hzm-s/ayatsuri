require 'spec_helper'
require 'ayatsuri/component/base'

module Ayatsuri
	module Component
		describe Base do
			let(:model) { described_class.new driver, parent, id }

			let(:driver) { mock 'driver' }
			let(:parent) { mock 'parent component' }
			let(:id) { mock 'component id' }

			describe "#driver" do
				subject { model.driver }
				it { should == driver }
			end

			describe "#parent" do
				subject { model.parent }
				it { should == parent }
			end

			describe "#id" do
				subject { model.id }
				it { should == id }
			end

			describe "#invoke" do
				subject { model.invoke operation, args }

				let(:operation) { :operate }
				let(:args) { mock('args for operation') }

				context "when successfully operated" do
					before do
						driver.should_receive(operation).with(args) { true }
					end
					it { should be_true }
				end

				context "when failed to operate" do
					before do
						driver.should_receive(operation).and_raise(ex)
					end
					let(:ex) { FailedToOperate }
					it { expect { subject }.to raise_error(ex) }
				end
			end
		end
	end
end

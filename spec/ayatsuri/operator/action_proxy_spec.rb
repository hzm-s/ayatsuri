require 'spec_helper'

module Ayatsuri
	class Operator
		describe ActionProxy do
			let(:model) { Object.new.extend(described_class) }

			describe "#method_missing" do
				subject { model.send(method, *args, &block) }

				let(:method) { :action_method }
				let(:args) { [:arg1, :arg2] }
				let(:block) { lambda { "block" } }

				before do
					model.stub(:driver) { driver }
					driver.stub(:respond_to?).with(method) { true }
				end

				let(:driver) { mock 'driver' }

				it "delegate given method to driver" do
					driver.should_receive(:send).with(method, *args, &block)
					subject
				end
			end
		end
	end
end

require 'spec_helper'

module Ayatsuri
	class Operation
		describe Condition do
			let(:model) { described_class.new &condition_block }

			let(:condition_block) { lambda { "condition to call operation" } }

			describe ".new" do
				subject { model }
				it { subject.block.should == condition_block }
			end

			describe "#match?" do
				subject { model.match? operator, timeout }

				let(:operator) { mock 'operator' }
				let(:timeout) { mock 'timeout' }

				let(:stub_wait_until) do
					model.stub(:wait_until).with(timeout, instance_of(String))
				end

				context "when match" do
					before { stub_wait_until.and_return(true) }
					it { should be_true }
				end

				context "when NOT match" do
					before { stub_wait_until.and_raise(Ayatsuri::Timeout) }
					it { should be_false }
				end
			end
		end
	end
end

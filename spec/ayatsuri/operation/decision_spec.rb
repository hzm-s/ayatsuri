require 'spec_helper'

shared_context "decisions" do
	let(:operation) do
		double(:operation).tap do |d|
			d.stub(:method_name) { method_name }
		end
	end

	let(:method_name) { :operate_method }

	let(:operator) { mock 'operator' }
end

module Ayatsuri
	class Operation
		class Decision

			describe Assign do
				include_context "decisions"

				describe "#perform" do
					subject { described_class.new(operation).perform(operator) }

					it "calls assign with operation to operator" do
						operator.should_receive(:assign).with(operation)
						subject
					end
				end
			end

			describe Timeout do
				include_context "decisions"

				describe "#perform" do
					subject { described_class.new(operation).perform(operator) }

					it { expect { subject }.to raise_error(Ayatsuri::ConditionMatchingTimeout) }
				end
			end
			
			describe Skip do
				include_context "decisions"

				describe "#perform" do
					subject { described_class.new(operation).perform(operator) }

					it "calls skip with operation to operator" do
						operator.should_receive(:skip).with(operation)
						subject
					end
				end
			end
		end
	end
end

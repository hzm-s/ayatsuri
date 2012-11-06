require 'spec_helper'

module Ayatsuri
	describe Operation do
		let(:model) { described_class.new condition, method_name, option }

		let(:condition) { mock 'condition' }
		let(:method_name) { :operation_method }
		let(:option) { { limit: limit } }

		describe "#decide" do
			subject { model.decide operator }

			let(:operator) { mock 'operator' }
			let(:decision) { mock 'decision' }

			before do
				condition.stub(:match?).with(operator, limit) { match }
			end

			context "when condition match" do
				let(:match) { true }
				let(:limit) { nil }

				before do
					Operation::Decision::Assign.stub(:new).with(model) { decision }
				end

				it { should == decision }
			end

			context "when condition NOT match" do
				let(:match) { false }

				context "given limit option" do
					let(:limit) { 1 }

					before do
						Operation::Decision::Skip.stub(:new).with(model) { decision }
					end

					it { should == decision }
				end

				context "given no limit option" do
					let(:limit) { nil }

					before do
						Operation::Decision::Timeout.stub(:new).with(model) { decision }
					end

					it { should == decision }
				end
			end
		end
	end
end

require 'spec_helper'

module Ayatsuri
	class Operation
		describe Condition do
			before do
				stub_const("Ayatsuri::Operation::Condition::Matcher", Class.new)
			end

			describe ".create" do
				subject { described_class.create spec }

				let(:condition) { mock 'condition' }
				let(:matcher) { mock 'matcher' }

				before do
					described_class.stub(:new).with(:method, matcher) { condition }
				end

				context "given spec as Hash" do
					let(:spec) { { method: "expectation" } }

					before do
						Condition::Matcher.stub(:create).with("expectation") { matcher }
					end

					it { should == condition }
				end

				context "given spec as Symbol" do
					let(:spec) { :method }

					before do
						Condition::Matcher.stub(:create).with(true) { matcher }
					end

					it { should == condition }
				end
			end

			let(:model) { described_class.new method, matcher }

			let(:spec) { { method => expectation } }
			let(:method) { mock 'method for candidate' }
			let(:matcher) { mock 'condition matcher' }

			describe "#satisfy?" do
				subject { model.satisfy? candidate }

				let(:candidate) { mock 'candidate' }

				before do
					candidate.stub(:send).with(method).and_return(actual)
					model.stub(:match?).with(actual).and_return(match_result)
				end

				let(:matcher) { mock 'condition matcher' }
				let(:actual) { mock 'actual that is returned from method for candidate' }

				context "when satisfy" do
					let(:match_result) { true }
					it { should be_true }
				end

				context "when NOT satisfy" do
					let(:match_result) { false }
					it { should be_false }
				end
			end
		end
	end
end

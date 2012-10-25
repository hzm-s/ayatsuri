require 'spec_helper'

shared_examples "real_matcher" do |option|
	subject { described_class.match? actual, option[:expectation] }

	context "when match" do
		let(:actual) { option[:match] }
		it { should be_true }
	end

	context "when NOT match" do
		let(:actual) { option[:not_match] }
		it { should be_false }
	end
end

module Ayatsuri
	class Operation
		class Condition

			describe RegexpMatcher do
				describe ".match?" do
					it_behaves_like "real_matcher",
						expectation: /match/,
						match: "ohmatchi",
						not_match: "macchi-shimasen"
				end
			end

			describe ValueMatcher do
				describe "#match?" do
					it_behaves_like "real_matcher",
						expectation: true,
						match: true,
						not_match: false
				end
			end

		end
	end
end

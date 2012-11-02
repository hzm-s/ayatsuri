require 'spec_helper'

__END__
module Ayatsuri
	class Operation
		class Condition
			describe Matcher do
				describe ".create" do
					subject { described_class.create expectation }

					before do
						stub_const("Ayatsuri::Operation::Condition::RegexpMatcher", Class.new)
						stub_const("Ayatsuri::Operation::Condition::ValueMatcher", Class.new)
						described_class.stub(:new).with(expectation, real_matcher) { matcher }
					end
	
					let(:matcher) { mock 'matcher' }
	
					context "when Regexp" do
						let(:expectation) { /expect/ }
						let(:real_matcher) { RegexpMatcher }
						it { should == matcher }
					end
	
					context "when any value" do
						let(:expectation) { "expectation" }
						let(:real_matcher) { ValueMatcher }
						it { should == matcher }
					end
				end

				describe "#match?" do
					subject { model.match? actual }

					let(:model) { described_class.new expectation, real_matcher }

					let(:actual) { mock 'match for actual' }
					let(:expectation) { mock 'expectation' }
					let(:real_matcher) do
						double('real matcher').tap do |d|
							d.stub(:match?).with(actual, expectation).and_return(match_result)
						end
					end

					context "when match" do
						let(:match_result) { true }
						it { should be_true }
					end

					context "when NOT match" do
						let(:match_result) { false }
						it { should be_false }
					end
				end
			end
		end
	end
end

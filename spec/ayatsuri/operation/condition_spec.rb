require 'spec_helper'

module Ayatsuri
	class Operation
		describe Condition do
			let(:query_method) { mock 'query method for window condition' }
			let(:matcher) { mock 'condition matcher' }

			describe ".create" do
				subject { described_class.create query_method, expectation }

				let(:expectation) { mock 'expectation' }

				before do
					Condition::Matcher.stub(:create).with(expectation) { matcher }
					described_class.stub(:new).with(query_method, matcher) { condition }
				end

				let(:condition) { mock 'condition' }

				it { should == condition }
			end

			let(:model) { described_class.new query_method, matcher }

			describe "#satisfy?" do
				subject { model.satisfy? candidate }
				
				let(:candidate) { mock 'candidate' }

				before do
					candidate.stub(:send).with(query_method) { actual }
					matcher.stub(:match?).with(actual) { result }
				end
				let(:actual) { mock 'actual' }

				context "when satisfied" do
					let(:result) { true }
					it { should be_true }
				end

				context "when NOT satisfied" do
					let(:result) { false }
					it { should be_false }
				end
			end
		end

		class Condition
			describe Matcher do
				describe ".create" do
					subject { described_class.create expectation }

					context "given regexp as expectation" do
						let(:expectation) { /expectation/ }
						it { should be_kind_of(Matcher::ByRegexp) }
					end

					context "given value as expectation" do
						let(:expectation) { 'expectation' }
						it { should be_kind_of(Matcher::ByEqual) }
					end
				end
			end
		end

		class Condition
			class Matcher
				describe "match strategy modules" do
					let(:model) { Object.new.extend(mod) }

					before { model.stub(:expectation) { expectation } }
					let(:expectation) { mock 'expectation' }

					let(:actual) { mock 'actual condition' }

					describe ByRegexp do
						let(:mod) { described_class }

						describe "#match?" do
							subject { model.match? actual }
							it "match by regexp" do
								actual.should_receive(:=~).with(expectation)
								subject
							end
						end
					end

					describe ByEqual do
						let(:mod) { described_class }

						describe "#match?" do
							subject { model.match? actual }
							it "match by equal" do
								actual.stub(:==).with(expectation)
								subject
							end
						end
					end
				end
			end
		end
	end
end

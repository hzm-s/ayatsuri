require 'spec_helper'

module Ayatsuri
	module AutoIt
		describe Identity do
			let(:model) { described_class.new option }

			let(:option) { { title: "the title" } }

			describe "#==" do
				subject { model == other }

				context "when equal" do
					let(:other) { described_class.new option }
					it { should be_true }
				end

				context "when NOT equal" do
					let(:other) { described_class.new({ title: "other title" }) }
					it { should be_false }
				end
			end
		end
	end
end

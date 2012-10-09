require 'spec_helper'

module Ayatsuri
	class Application
		describe Control do
			let(:model) { described_class.new id_spec }

			let(:id_spec) { { id: 1 } }

			describe "#==" do
				subject { model == other }

				context "when equal" do
					let(:other) { described_class.new id_spec }
					it { should be_true }
				end

				context "when NOT equal" do
					let(:other) { described_class.new({ id: 9 }) }
					it { should be_false }
				end
			end
		end
	end
end

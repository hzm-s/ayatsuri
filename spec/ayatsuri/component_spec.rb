require 'spec_helper'

module Ayatsuri
	describe Component do
		describe ".available_type?" do
			subject { described_class.available_type? type }

			before do
				described_class.available_types = [:available_type]
			end

			let(:type) { :available_type }

			context "when available" do
				it { should be_true }
			end

			context "when NOT available" do
				let(:type) { :unavailable_type }
				it { should be_false }
			end
		end
	end
end

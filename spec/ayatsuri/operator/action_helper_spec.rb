require 'spec_helper'

module Ayatsuri
	class Operator
		describe ActionHelper do
			let(:model) { Object.new.extend(described_class) }

			describe "#keys" do
				subject { model.keys key, count }

				let(:key) { "{TAB}" }
				let(:count) { 5 }

				it { should == ["{TAB}", "{TAB}", "{TAB}", "{TAB}", "{TAB}"] }
			end
		end
	end
end

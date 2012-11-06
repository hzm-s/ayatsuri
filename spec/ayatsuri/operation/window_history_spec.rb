require 'spec_helper'

module Ayatsuri
	class Operator
		describe WindowHistory do
			let(:model) { described_class.new }

			describe "#log" do
				subject { model.log window }

				let(:window) { mock 'window' }

				it { should == window }
			end
		end
	end
end

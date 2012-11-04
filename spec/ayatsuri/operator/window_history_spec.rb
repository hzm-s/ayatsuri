require 'spec_helper'

module Ayatsuri
	class Operator
		describe WindowHistory do
			let(:model) { described_class.new }

			describe "#<<" do
				subject { model << window }

				let(:window) { mock 'window' }

				it { subject; model.all.should == [window] }
			end
		end
	end
end

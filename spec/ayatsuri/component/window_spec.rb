require 'spec_helper'

module Ayatsuri
	module Component
		describe Window do
			let(:model) { described_class.new parent, id }

			let(:parent) { mock 'parent component' }
			let(:id) { mock 'window id' }

			describe ".new" do
				subject { model }

				it { subject.should be_kind_of(Base) }
				it { subject.should be_kind_of(Behavior::Containable) }
			end
		end
	end
end

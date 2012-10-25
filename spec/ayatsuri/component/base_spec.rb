require 'spec_helper'
require 'ayatsuri/component/base'

module Ayatsuri
	module Component
		describe Base do
			let(:model) { described_class.new parent, id }

			let(:parent) { mock 'parent component' }
			let(:id) { mock 'component id' }

			describe "#parent" do
				subject { model.parent }
				it { should == parent }
			end

			describe "#id" do
				subject { model.id }
				it { should == id }
			end
		end
	end
end

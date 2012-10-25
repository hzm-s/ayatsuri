require 'spec_helper'

module Ayatsuri
	module Component
		describe Control do
			let(:model) { described_class.new parent, type, id }

			let(:parent) { mock 'window' }
			let(:type) { "component type" }
			let(:id) { { id: 1 } }

			describe ".create" do
				subject { described_class.create parent, type, id }

				it "construct self" do
					described_class.should_receive(:new).with(parent, type, id)
					subject
				end
			end

			describe "#component_type" do
				subject { model.component_type }
				it { should == type }
			end

			describe "#identifier" do
				subject { model.identifier }
				it { should == id }
			end

			describe "#parent" do
			end

			describe "#parent_identifier" do
				subject { model.parent_identifier }
				
				before { parent.should_receive(:identifier) { parent_id } }
				let(:parent_id) { mock 'parent identifier' }
				it { should == parent_id }
			end
		end
	end
end

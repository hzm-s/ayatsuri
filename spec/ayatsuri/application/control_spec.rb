require 'spec_helper'

module Ayatsuri
	class Application
		describe Control do
			let(:model) { described_class.new type, parent, id_spec }

			let(:type) { "component type" }
			let(:parent) { Window.new(mock('automation driver'), "parent") }
			let(:id_spec) { { id: 1 } }

			describe "#component_type" do
				subject { model.component_type }
				it { should == type }
			end

			describe "#click" do
				subject { model.click }

				it "delegates click to parent" do
					parent.should_receive(:operate).with(:click, model)
					subject
				end
			end

			describe "#==" do
				subject { model == other }

				context "when equal" do
					let(:other) { described_class.new type, parent, id_spec }
					it { should be_true }
				end

				context "when NOT equal" do
					let(:other) { described_class.new(type, parent, id: 9) }
					it { should be_false }
				end
			end
		end
	end
end

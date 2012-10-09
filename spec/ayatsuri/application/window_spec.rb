require 'spec_helper'

module Ayatsuri
	class Application
		describe Window do
			let(:model) { described_class.new parent, id_spec }

			let(:parent) { nil }
			let(:id_spec) { { title: "the window title" } }

			describe "#append_child" do
				subject { model.append_child name, child }

				let(:name) { "control1" }
				let(:child) { mock 'a child component' }

				it { subject.child(name).should == child }
			end

			describe "#==" do
				subject { model == other }

				context "when equal" do
					let(:other) { described_class.new parent, id_spec }
					it { should be_true }
				end

				context "when NOT equal" do
					let(:other) { described_class.new :root, id_spec }
					it { should be_false }
				end
			end
		end
	end
end

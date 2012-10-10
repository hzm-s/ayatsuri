require 'spec_helper'

module Ayatsuri
	class Application
		describe Window do
			let(:model) { described_class.new title }

			let(:title) { "the window title" }

			describe ".new" do
				subject { model }
				it { subject.title.should == title }
			end

			describe "#build" do
				specify { expect {|b| model.build(&b) }.to yield_control }
				it "building self children using WindowBuilder" do
					WindowBuilder.should_receive(:new).with(model)
					model.build do
						# building block
					end
				end
			end

			describe "#==" do
				subject { model == other }

				context "when equal" do
					let(:other) { described_class.new title }
					it { should be_true }
				end

				context "when NOT equal" do
					let(:other) { described_class.new "other window" }
					it { should be_false }
				end
			end
		end
	end
end

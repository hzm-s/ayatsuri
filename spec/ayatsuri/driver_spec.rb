require 'spec_helper'

module Ayatruri; module AutomationAdapter; module Ayatsuri; end; end; end

module Ayatsuri
	describe Driver do
		let(:model) { described_class.create(adapter_name, exe) }

		let(:adapter_name) { "ayatsuri" }
		let(:exe) { "application.exe" }

		after { described_class.flush }

		describe ".create" do
			subject { model }

			it "extends adapter" do
				subject.should be_kind_of(Ayatsuri)
			end

			context "when create twice" do
				context "when create again" do
					it { subject.should == described_class.create(adapter_name, exe) }
				end

				context "when create other exe" do
					it { subject.should_not == described_class.create(adapter_name, "otherapp.exe") }
				end
			end
		end

		describe ".new" do
			subject { described_class.new mock('automation adapter'), exe }
			it { expect { subject }.to raise_error(NoMethodError) }
		end
	end
end

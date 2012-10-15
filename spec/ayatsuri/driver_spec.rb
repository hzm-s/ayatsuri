require 'spec_helper'

module Ayatruri; module AutomationEngine; module Ayatsuri; end; end; end

module Ayatsuri
	describe Driver do
		let(:model) { described_class.create(exe, engine) }

		let(:exe) { "application.exe" }
		let(:engine) { Ayatsuri }

		before do
			engine.stub(:create_interface).and_return(engine_interface)
		end

		let(:engine_interface) { double 'automation engine interface' }

		after { described_class.flush }

		describe ".create" do
			subject { model }

			it "creates interface of given engine and extends engine" do
				engine.should_receive(:create_interface)
				subject.should be_kind_of(engine)
			end

			context "when create twice" do
				context "when create again" do
					it { subject.should == described_class.create(exe, engine) }
				end

				context "when create other exe" do
					it { subject.should_not == described_class.create("other.exe", engine) }
				end
			end
		end

		describe ".new" do
			subject { described_class.new mock('automation engine'), exe }
			it { expect { subject }.to raise_error(NoMethodError) }
		end

		describe "#drive" do
			subject { model.drive method, args }

			let(:method) { :action }
			let(:args) { mock 'args' }

			it "delegate given method and args to automation engine interface" do
				engine_interface.should_receive(:send).with(method, args)
				subject
			end
		end
	end
end

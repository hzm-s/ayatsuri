require 'spec_helper'

module Ayatruri
	module AutomationEngine
		module Ayatsuri
		end
	end
end

module Ayatsuri
	describe Driver do
		let(:model) { described_class.create(exe, engine) }

		let(:exe) { "application.exe" }
		let(:engine) { Ayatsuri }

		before do
			engine.stub(:interface).and_return(engine_interface)
		end

		let(:engine_interface) { mock 'automation engine interface' }

		describe ".create" do
			subject { described_class.create exe, engine }

			it { should == described_class.create(exe, engine) }
			it { should be_kind_of(engine) }
			it { should_not == described_class.create("otherapp.exe", engine) }
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
				engine_interface.should_receive(method).with(args)
				subject
			end
		end
	end
end

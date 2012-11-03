require 'spec_helper'

shared_context "starter" do
	before { Ayatsuri::Driver.stub(:instance) { driver } }
	let(:exe_path) { "/path/to/application.exe" }
	let(:driver) { mock 'driver instance' }
end

module Ayatsuri
	class Application
		describe Starter do
			include_context "starter"

			subject { described_class.create exe_path, starter_name }

			let(:starter_name) { :fake }

			before do
				stub_const("Ayatsuri::Application::Starter::Fake", Class.new)
				Ayatsuri::Application::Starter::Fake.stub(:new).with(exe_path) { starter }
			end

			let(:starter) { mock 'application starter instance' }

			it { should == starter }
		end

		class Starter

			describe Clickonce do
				include_context "starter"

				let(:model) { described_class.new exe_path }

				describe "#start" do
					subject { model.start }

					before do
						driver.stub(:invoke).with(:Send, "#r") { true }
						driver.stub(:window_exist?) { true }
						driver.stub(:invoke).with(:Send, "#{exe_path}{ENTER}") { true }
					end

					it { should be_true }
				end
			end

			describe Default do
				include_context "starter"

				let(:model) { described_class.new exe_path }

				describe "#start" do
					subject { model.start }

					before do
						driver.stub(:run_application).with(exe_path) { true }
					end

					it { should be_true }
				end
			end
		end
	end
end

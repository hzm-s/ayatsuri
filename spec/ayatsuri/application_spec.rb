require 'spec_helper'

module Ayatsuri
	describe Application do
		let(:model) { described_class.new exe_path }

		let(:exe_path) { "application.exe" }

		let(:operator) { mock 'operator' }

		describe "#running?" do
			subject { model.running? }

			context "when running" do
				before do
					model.run(operator.tap {|o| o.stub(:run) })
				end
				it { should be_true }
			end

			context "when NOT running" do
				it { should be_false }
			end
		end

		describe "application command" do
			describe "#run" do
				subject { model.run operator }

				before { operator.stub(:run).with(model) }

				it { subject; model.running?.should be_true }
			end

			describe "#quit" do
				subject { model.quit operator }

				before { model.stub(:running?).and_return(running) }

				context "when application is running" do
					let(:running) { true }
					before { operator.stub(:quit).with(model) { exe_path } }
					it { should == exe_path }
				end

				context "when application has NOT ran" do
					let(:running) { false }
					it { should be_nil }
				end
			end
		end

		describe "#create_root_window" do
			subject { model.create_root_window id, &create_child_block }

			let(:id) { "window title" }
			let(:create_child_block) { Proc.new { "create child component block" } }

			before do
				Component.stub(:create).with(:window, nil, id).and_return(root_window)
			end

			let(:root_window) { mock 'root window' }

			context "given block for create child components" do
				before do
					Component.should_receive(:build).
						with(root_window, &create_child_block).
						and_return(root_window)
				end

				it { subject.root_window.should == root_window }
			end

			context "NOT given block" do
				let(:create_child_block) { nil }
				it { subject.root_window.should == root_window }
			end
		end
	end
end

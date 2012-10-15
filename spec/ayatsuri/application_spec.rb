require 'spec_helper'

module Ayatsuri
	describe Application do
		let(:mod) { described_class }

		before do
			mod.initialize_application
		end

		describe ".ayatsuri_for" do
			subject { mod.ayatsuri_for exe, root_window_id, &build_block }

			let(:exe) { "app.exe" }
			let(:root_window_id) { mock 'root window identity' }
			let(:build_block) { Proc.new { "build block" } }

			let(:driver) { mock 'automation driver' }
			let(:builder) { mock 'builder' }
			let(:root_window) { mock 'root window' }

			it "creates driver for exe and build components" do
				Driver.should_receive(:create).with(exe).and_return(driver)
				Application::ComponentBuilder.should_receive(:new).
					with(driver, mod).and_return(builder)
				builder.should_receive(:window).
					with("root", root_window_id, &build_block).and_return(root_window)
				subject.should == root_window
			end
		end

		describe ".append_child" do
			subject { mod.append_child name, child }

			let(:name) { mock 'name' }
			let(:child) { mock 'root window' }

			it "register given child to component repository" do
				Application::ComponentRepository.any_instance.
					should_receive(:register).with(name, child)
				subject
			end
		end
	end
end

__END__
class App < Ayatsuri::Application
	ayatsuri_for "app.exe", "the app" do
		label "label1", id: 1
		button "button1", id: 2
		window "sub1", "subwindow 1" do
			button "button2", id: 3
		end
	end
end

module Ayatsuri
	describe App do
		let(:app_class) { described_class }
		let(:model) { app_class.new }

		describe "#driver" do
			subject { model.driver }
			it { should == Driver.create("app.exe") }
		end

		describe "#root_window" do
			subject { model.root_window }

			it { should == Application::Window.new(model.driver, "the app") }
		end

		describe "#window" do
			subject { model.window "sub1" }

			it { should == Application::Window.new(model.driver, "subwindow 1") }
		end

		describe "#label" do
			subject { model.label name }

			let(:name) { "label1" }
			let(:id_spec) { { id: 1 } }

			context "given defined label name" do
				it { should == Application::Control.new(:label, model.root_window, id_spec) }
			end
		end

		describe "#button" do
			subject { model.button name }
			let(:name) { "button1" }
			let(:id_spec) { { id: 2 } }

			context "given defined button name" do
				it { should == Application::Control.new(:button, model.root_window, id_spec) }
			end
		end
	end
end

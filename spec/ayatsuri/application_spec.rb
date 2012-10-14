require 'spec_helper'

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

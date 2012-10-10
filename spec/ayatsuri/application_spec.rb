require 'spec_helper'

class App < Ayatsuri::Application
	ayatsuri_for "app.exe", "the app" do
		textbox "textbox1", id: 1
	end
end

module Ayatsuri
	describe Application do
		let(:model) { App.new }

		describe "#exe" do
			subject { model.exe }

			it { should == "app.exe" }
		end

		describe "#root_window" do
			subject { model.root_window }

			it { should == Application::Window.new("the app") }
		end

		describe "#textbox" do
			subject { model.textbox name }

			let(:name) { "textbox1" }
			let(:id_spec) { { id: 1 } }

			context "given defined textbox name" do
				it { should == Application::Control.new(name, id_spec, "main") }
			end
		end
	end
end

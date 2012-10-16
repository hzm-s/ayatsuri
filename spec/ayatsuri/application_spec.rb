require 'spec_helper'

class App < Ayatsuri::Application; end

module Ayatsuri
	describe Application do
		let(:app) { App }

		describe ".ayatsuri_for" do
			subject { app.ayatsuri_for exe, root_window_id, &build_block }

			let(:exe) { "app.exe" }
			let(:root_window_id) { mock 'root window identity' }
			let(:build_block) { Proc.new { "build block" } }

			let(:driver) { mock 'automation driver' }
			let(:builder) { mock 'builder' }
			let(:root_window) { mock 'root window' }

			before do
				Driver.should_receive(:create).with("autoit", exe).and_return(driver)
				Component::Builder.should_receive(:new).
					with(driver, app).and_return(builder)
				builder.stub(:window) {|name, id, &block| app.append_child(name, root_window) }
			end

			it "setup application" do
				subject
				app.root_window.should == root_window
				app.driver.should == driver
			end
		end

		describe ".append_child" do
			subject { app.append_child name, child }

			let(:name) { mock 'name' }
			let(:child) { mock 'root window' }

			it "appends given child component" do
				subject.should == child
				app.root_window.should == child
			end
		end

		context "when constructed application" do
			let(:model) { app.new }

			describe "#boot" do
				subject { model.boot }

				let(:driver) { mock 'automation driver' }

				it "calls boot to driver" do
					app.should_receive(:driver).and_return(driver)
					driver.should_receive(:boot)
					subject
				end
			end

			describe "accessing child components" do
				subject { model.send(component_type, name) } 

				let(:component_type) { :component }
				let(:name) { "component name" }

				context "when available component" do
					before do
						Component.should_receive(:available_type?).with(component_type).and_return(true)
					end

					let(:root_window) { mock 'root window' }
					let(:child) { mock 'child component' }

					it "fetches child component from root window" do
						app.should_receive(:root_window).and_return(root_window)
						root_window.should_receive(:find_child).with(component_type, name).and_return(child)
						subject.should == child
					end
				end
			end
		end
	end
end

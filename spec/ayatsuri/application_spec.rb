require 'spec_helper'

module Ayatsuri
	describe Application do
		let(:model) { described_class.create adapter, app_id }

		let(:adapter) { :autoit }
		let(:app_id) { "application.exe" }

		let(:driver) { mock 'driver' }

		before do
			Driver.stub(:create).with(adapter).and_return(driver)
		end

		describe ".create" do
			subject { model }
			it { subject.driver.should == driver }
			it { subject.id.should == app_id }
		end

		describe "#create_root_window" do
			subject { model.create_root_window id, &create_child_block }

			let(:id) { "window title" }
			let(:create_child_block) { Proc.new { "create child component block" } }

			before do
				Component.stub(:create).with(:window, driver, nil, id).and_return(root_window)
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
__END__
		let(:app) { App }

		let(:driver) { mock 'automation driver' }
		let(:application) { "app.exe" }
		let(:root_window) { mock 'root window' }

		describe ".ayatsuri_for" do
			subject { app.ayatsuri_for application, root_window_id, &build_block }

			let(:root_window_id) { mock 'root window identity' }
			let(:build_block) { Proc.new { "build block" } }

			let(:builder) { mock 'builder' }

			before do
				Driver.should_receive(:create).with("autoit").and_return(driver)
				Component::Builder.should_receive(:new).
					with(driver, app).and_return(builder)
				builder.stub(:window) {|name, id, &block| app.append_child(name, root_window) }
			end

			it "setup application" do
				subject
				app.application.should == application
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

			before do
				app.tap do |klass|
					klass.stub(:application).and_return(application)
					klass.stub(:driver).and_return(driver)
					klass.stub(:root_window).and_return(root_window)
				end
			end

			describe "#boot!" do
				subject { model.boot! &block }

				let(:block) { Proc.new { "operate block" } }

				let(:stub_boot) { driver.should_receive(:boot!).with(application) }

				context "when successful" do
					before { stub_boot.and_return(true) }

					context "when block given" do
						it "boots application and execute given block and shutdown application when finished" do
							model.should_receive(:instance_exec).with(&block)
							driver.should_receive(:shutdown!).with(root_window)
							subject
						end
					end

					context "when NOT block given" do
						let(:block) { nil }

						it "just boots application" do
							model.boot!
						end
					end
				end

				context "when failed" do
					let(:error) { FailedToBootApplication }
					before { stub_boot.and_raise(error) }
					it { expect { model.boot! }.to raise_error(error) }
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

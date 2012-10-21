require 'spec_helper'

module Ayatsuri
	module Component
		describe Builder do
			let(:model) { described_class.new component }

			let(:component) { mock 'component' }

			describe "#build" do
				subject { model.build &block }

				let(:block) { Proc.new { "block for create child components" } }

				before do
					model.stub(:instance_exec).with(&block).and_return(built_component)
				end

				let(:built_component) { mock 'component that is create child components' }

				it { should == built_component }
			end

			describe "create child component" do
				subject { model.send(component_type, name, id) }

				let(:component_type) { :anything }
				let(:name) { "component name" }
				let(:id) { "component id" }

				before { model.stub(:parent).and_return(parent_component) }

				let(:parent_component) do
					double('parent component').tap do |d|
						d.stub(:driver).and_return(driver)
						d.stub(:append_child).with(name, child_component).and_return(d)
						d.stub(:find_child).with(name).and_return(child_component)
					end
				end

				let(:driver) { mock 'driver' }
				let(:child_component) { mock 'child component' }

				context "given available component type" do
					before do
						Component.stub(:create).
							with(component_type, driver, parent_component, id).
							and_return(child_component)
					end

					it { subject.find_child(name).should == child_component }
				end

				context "given unavailable component type" do
					before do
						Component.stub(:create).and_raise(ex)
					end

					let(:ex) { UnavailableComponentType }

					it { expect { subject }.to raise_error(ex) }
				end
			end
		end
	end
end
__END__
			let(:model) { described_class.new driver, parent }

			let(:driver) { mock 'automation driver' }
			let(:parent) { mock 'parent component' }

			describe "#window" do
				before { model }

				let(:name) { "a window name" }
				let(:id) { mock 'automation component identifier' }
				let(:window) { mock 'window' }

				before do
					Window.should_receive(:create).with(driver, id).and_return(window)
				end

				context "given only window parameters" do
					subject { model.window name, id }

					it "1) create window 2) append *1 to parent" do
						parent.should_receive(:append_child).with(name, window).and_return(window)
						subject.should == window
					end
				end

				context "given block" do
					subject { model.window name, id, &build_block }

					let(:builder_for_child) { mock 'builder for child' }
					let(:built_window) { mock 'built window' }
					let(:build_block) { Proc.new{ "build block" } }

					it "1) create window 2) new builder for *1, 3) append *1 to parent" do
						described_class.should_receive(:new).with(driver, window).and_return(builder_for_child)
						builder_for_child.should_receive(:instance_exec).with(&build_block).and_return(built_window)
						parent.should_receive(:append_child).with(name, built_window).and_return(built_window)
						subject.should == built_window
					end
				end
			end

			describe "build controls" do
				let(:name) { "a control name" }
				let(:id) { "automation control identifier" }

				let(:control) { mock 'control' }

				shared_examples "build control" do |control_type|
					subject { model.send(control_type, name, id) }

					it "creates #{control_type} control and append it to parent" do
						Control.should_receive(:create).with(driver, parent, control_type, id).and_return(control)
						parent.should_receive(:append_child).with(name, control)
						subject.should == parent
					end
				end

				describe "#label" do
					it_behaves_like "build control", :label
				end

				describe "#button" do
					it_behaves_like "build control", :button
				end

				describe "#textbox" do
					it_behaves_like "build control", :textbox
				end
			end
		end
	end
end

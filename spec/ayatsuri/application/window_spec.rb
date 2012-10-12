require 'spec_helper'

module Ayatsuri
	class Application
		describe Window do
			let(:model) { described_class.new driver, title }

			let(:driver) { mock 'automation driver' }
			let(:title) { "the window title" }

			describe ".new" do
				subject { model }
				it { subject.driver.should == driver }
				it { subject.title.should == title }
			end

			describe "#build" do
				specify { expect {|b| model.build(&b) }.to yield_control }

				it "building self using WindowBuilder" do
					Window::Builder.should_receive(:new).with(model)
					model.build do
						# building block
					end
				end
			end

			describe "#append_child" do
				subject { model.append_child name, child }

				let(:name) { "child" }
				let(:child) { mock 'child component' }

				it "register child to ComponentManager" do
					Window::ComponentManager.any_instance.should_receive(:register).with(name, child)
					subject.should == model
				end
			end

			describe "#find_child" do
				subject { model.find_child type, name }

				let(:type) { mock 'component type' }
				let(:name) { "child component name" }
				let(:child_component) { mock 'child component' }

				it "finds child component using ComponentManager" do
					Window::ComponentManager.any_instance.
						should_receive(:fetch).with(type, name).
						and_return(child_component)
					subject.should == child_component
				end
			end

			describe "#operate" do
				subject { model.operate action, control }

				let(:action) { :action }
				let(:control) { mock 'child control' }

				it "calls control method to driver" do
					driver.should_receive(action).with(model, control)
					subject
				end
			end

			describe "#activate" do
				subject { model.activate }

				it "calls activate_window with self to driver" do
					driver.should_receive(:activate_window).with(model)
					subject
				end
			end

			describe "#component_type" do
				subject { model.component_type }
				it { should == :window }
			end

			describe "#==" do
				subject { model == other }

				context "when equal" do
					let(:other) { described_class.new driver, title }
					it { should be_true }
				end

				context "when NOT equal" do
					let(:other) { described_class.new driver, "other window" }
					it { should be_false }
				end
			end
		end
	end
end

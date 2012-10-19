require 'spec_helper'

module Ayatsuri
	module Component
		describe Window do
			let(:model) { described_class.new driver, id }

			let(:driver) { mock 'automation driver' }
			let(:id) { "window identifier for adapter" }

			describe ".create" do
				subject { described_class.create driver, id_spec }

				let(:id_spec) { mock "id spec" }

				it "calls new to self" do
					driver.should_receive(:create_window_identifier).with(id_spec).and_return(id)
					described_class.should_receive(:new).with(driver, id)
					subject
				end
			end

			describe "#component_type" do
				subject { model.component_type }
				it { should == :window }
			end

			describe "#identifier" do
				subject { model.identifier }
				it { should == id }
			end

			describe "#append_child" do
				subject { model.append_child name, child }

				let(:name) { mock 'child name' }
				let(:child) { mock 'child component' }

				it "register child to component repository" do
					Repository.any_instance.should_receive(:register).with(name, child).and_return(child)
					subject.should == child
				end
			end

			describe "#find_child" do
				subject { model.find_child component_type, name }

				let(:component_type) { mock 'component_type' }
				let(:name) { mock 'component name' }
				let(:child) { double('child component') }

				it "finds child from component repository" do
					Repository.any_instance.should_receive(:fetch).with(component_type, name).
						and_return(child)
					subject.should == child
				end
			end

			describe "#activate" do
				subject { model.activate }

				it "calls activate to driver" do
					driver.should_receive(:activate).with(model)
					subject
				end
			end
		end
	end
end

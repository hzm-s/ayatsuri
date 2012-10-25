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
						d.stub(:append_child).with(name, child_component).and_return(d)
						d.stub(:find_child).with(name).and_return(child_component)
					end
				end

				let(:child_component) { mock 'child component' }

				context "given available component type" do
					before do
						Component.stub(:create).
							with(component_type, parent_component, id).
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

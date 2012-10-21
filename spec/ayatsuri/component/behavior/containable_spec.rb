require 'spec_helper'
require 'ayatsuri/component/behavior/containable'

module Ayatsuri
	module Component
		module Behavior
			describe Containable do
				let(:base) { Class.new }
				let(:model) { base.class_eval { include Containable }.new }

				let(:child_repository) { mock 'child_repository' }

				describe "#child_repository" do
					subject { model.child_repository }

					before do
						Repository.stub(:new).and_return(child_repository)
					end

					it { should == child_repository }
				end

				describe "#append_child" do
					subject { model.append_child name, child }

					let(:name) { "child_name" }
					let(:child) do
						double('child component').tap {|d| d.stub(:component_type).and_return(child_type) }
					end
					let(:child_type) { mock 'child component type' }

					before do
						model.stub(:child_repository).and_return(child_repository)
						child_repository.tap do |d|
							d.stub(:register).with(name, child).and_return(d)
							d.stub(:fetch).with(child_type, name).and_return(child)
						end
					end

					it { subject.child_repository.fetch(child_type, name).should == child }
				end

				describe "#find_child" do
					subject { model.find_child component_type, name }

					let(:component_type) { mock 'child component type' }
					let(:name) { mock 'child component name' }

					before do
						model.stub(:child_repository).and_return(child_repository)
						child_repository.tap do |d|
							d.stub(:fetch).with(component_type, name).and_return(child_component)
						end
					end
					let(:child_component) { mock 'child component' }

					it { should == child_component }
				end
			end
		end
	end
end

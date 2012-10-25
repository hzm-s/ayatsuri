require 'spec_helper'

module Ayatsuri
	describe Component do
		let(:mod) { described_class }

		describe ".create" do
			subject { mod.create type, parent, id }

			let(:type) { :anything }
			let(:parent) { mock 'parent component' }
			let(:id) { "component id" }

			context "given available component type" do
				before do
					stub_const("Ayatsuri::Component::Anything", Class.new)
					Component::Anything.stub(:new).with(parent, id)
						.and_return(component)
				end

				let(:component) { mock 'a component' }

				it { should == component }
			end

			context "given unavailable component type" do
				it { expect { subject }.to raise_error(UnavailableComponentType) }
			end
		end

		describe ".build" do
			subject { mod.build component, &create_child_block }

			let(:component) { mock 'component for build' }
			let(:create_child_block) { Proc.new { "create child block" } }

			before do
				Component::Builder.stub(:new).with(component).
					and_return(builder)
				builder.stub(:build).with(&create_child_block).
					and_return(built_component)
			end

			let(:builder) { mock 'component builder' }
			let(:built_component) { mock 'component built by Builder' }

			it { should == built_component }
		end
	end
end

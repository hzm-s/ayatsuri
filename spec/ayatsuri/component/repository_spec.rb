require 'spec_helper'

module Ayatsuri
	module Component
		describe Repository do
			let(:model) { described_class.new }

			describe "#register" do
				subject { model.register name, component }
				
				context "given valid parameters" do
					context "given window" do
						let(:name) { "window" }
						let(:component) { double('window').tap {|d| d.stub(:component_type).and_return(:window) } }

						it "registers given component" do
							subject.should == component
							model.fetch(:window, name).should == component
						end
					end

					context "given control component" do
						let(:name) { "control" }
						let(:component) { double('control').tap {|d| d.stub(:component_type).and_return(:button) } }

						it "registers given control" do
							subject.should == component
							model.fetch(:button, name).should == component
						end
					end
				end

				context "given invalid parameters" do
					let(:name) { "component" }

					let(:component) { double('component').tap {|d| d.stub(:component_type).and_return(:any) } }

					context "when missing name" do
						let(:name) { nil }
						it { expect { subject }.to raise_error(ArgumentError) }
					end

					context "when missing component" do
						let(:component) { nil }
						it { expect { subject }.to raise_error(ArgumentError) }
					end
				end
			end

			describe "#fetch" do
				subject { model.fetch component_type, name }

				let(:component_type) { mock 'component_type' }
				let(:name) { mock 'component name' }
				let(:child) { double('child component').tap {|d| d.stub(:component_type) { component_type } } }

				context "when child is registered" do
					before { model.register(name, child) }

					it { should == child }
				end

				context "when child is NOT registered" do
					context "when component_type is NOT registered" do
						it { should be_nil }
					end

					context "when name is NOT registered" do
						before { model.register("other name", child) }
						
						it { should be_nil }
					end
				end
			end
		end
	end
end

require 'spec_helper'

module Ayatsuri
	class Application
		describe ComponentRepository do
			let(:model) { described_class.new }

			describe "#register" do
				subject { model.register name, component }
				
				context "given valid parameters" do
					context "given window" do
						let(:name) { "window" }
						let(:component) { Window.new(mock('automation driver'), "a window") }

						it { subject.fetch(:window, name).should == component }
					end

					context "given control component" do
						let(:name) { "control" }
						let(:component) { Control.new(:button, Window.new(mock('automation driver'), "parent"), id: 1) }

						it { subject.fetch(:button, name).should == component }
					end
				end

				context "given invalid parameters" do
					let(:name) { "component" }

					let(:component) do
						d = double 'component'
						d.stub(:component_type) { :any }
						d
					end

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
		end
	end
end

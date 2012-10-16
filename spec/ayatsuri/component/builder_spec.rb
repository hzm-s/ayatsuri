require 'spec_helper'

module Ayatsuri
	module Component
		describe Builder do
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

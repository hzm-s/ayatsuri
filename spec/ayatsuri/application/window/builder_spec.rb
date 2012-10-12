require 'spec_helper'

module Ayatsuri
	class Application
		class Window
			describe Builder do
				let(:model) { described_class.new window }
	
				let(:window) do
					d = double 'parent window'
					d.stub(:driver).and_return(driver)
					d
				end
				let(:driver) { mock 'automation driver' }
	
				describe "#window" do
					subject { model.window name, title }
	
					let(:name) { "window1" }
					let(:title) { "window 1" }
	
					let(:child_window) { mock 'window' }
	
					it "calls append_child to parent with Window instance" do
						Window.should_receive(:new).with(driver, title).and_return(child_window)
						window.should_receive(:append_child).with(name, child_window)
						subject
					end
				end
	
				describe "build with control component" do
					let(:name) { "control" }
					let(:id_spec) { { id: 1 } }

					describe "#label" do
						subject { model.label name, id_spec }
	
						it "creates control and append it" do
							window.should_receive(:append_child).with(name, Control.new(:label, window, id_spec))
							subject
						end
					end

					describe "#button" do
						subject { model.button name, id_spec }

						it "creates control and append it" do
							window.should_receive(:append_child).with(name, Control.new(:button, window, id_spec))
							subject
						end
					end
				end
			end
		end
	end
end

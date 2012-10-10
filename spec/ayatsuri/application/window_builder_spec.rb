require 'spec_helper'

module Ayatsuri
	class Application
		describe WindowBuilder do
			let(:model) { described_class.new parent }

			let(:parent) { mock 'parent window' }

			describe "#window" do
				subject { model.window name, title }

				let(:name) { "window1" }
				let(:title) { "window 1" }

				let(:child_window) { Window.new(title) }

				it "calls append_child to parent with Window instance" do
					parent.should_receive(:append_child).with(name, child_window)
					subject
				end
			end
		end
	end
end

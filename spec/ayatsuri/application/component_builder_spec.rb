require 'spec_helper'

module Ayatsuri
	class Application
		describe ComponentBuilder do
			let(:model) { described_class.new driver, parent }

			let(:driver) { mock 'automation driver' }
			let(:parent) { mock 'parent component' }

			describe "#window" do
				before { model }

				let(:name) { "a window name" }
				let(:spec) { mock 'automation component spec' }
				let(:id_for_auto) { mock 'identity for automation' }
				let(:window) { mock 'window' }

				before do
					driver.should_receive(:create_identity).with(spec).and_return(id_for_auto)
					Window.should_receive(:new).with(driver, id_for_auto).and_return(window)
				end

				context "given only window parameters" do
					subject { model.window name, spec }

					it "1) create window 2) append *1 to parent" do
						parent.should_receive(:append_child).with(name, window)
						subject
					end
				end

				context "given block" do
					subject { model.window name, spec, &build_block }

					let(:builder_for_child) { mock 'builder for child' }
					let(:built_window) { mock 'built window' }
					let(:build_block) { Proc.new{ "build block" } }

					it "1) create window 2) new builder for *1, 3) append *1 to parent" do
						described_class.should_receive(:new).with(driver, window).and_return(builder_for_child)
						builder_for_child.should_receive(:instance_exec).with(&build_block).and_return(built_window)
						parent.should_receive(:append_child).with(name, built_window)
						subject
					end
				end
			end
		end
	end
end

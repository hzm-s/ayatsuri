require 'spec_helper'

module Ayatsuri
	describe Base do
		let(:klass) { described_class }
		
		describe ".ayatsuri_for" do
			subject { klass.ayatsuri_for app_id, root_window_id, &create_component_block }

			let(:app_id) { "application.exe" }
			let(:root_window_id) { "root window identifier" }
			let(:create_component_block) { Proc.new { "create components block" } }

			before do
				Application.should_receive(:create).with(:autoit, app_id) { application }
			end

			let(:application) { mock 'application' }
			let(:stub_create_root_window) { application.should_receive(:create_root_window) }

			context "given block" do
				it "builds root window and its sub components" do
					stub_create_root_window.with(root_window_id, &create_component_block).and_return(nil)
					subject.application.should == application
				end
			end

			context "NOT given block" do
				let(:create_component_block) { nil }

				it "builds root window only" do
					stub_create_root_window.with(root_window_id).and_return(nil)
					subject.application.should == application
				end
			end
		end
	end
end

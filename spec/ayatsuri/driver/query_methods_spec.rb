require 'spec_helper'

module Ayatsuri
	class Driver
		describe QueryMethods do
			let(:model) { Object.new.extend(described_class) }

			before do
				model.stub(:query).with(*query_args) { result }
			end

			let(:result) { "query result" }

			describe "#get_active_window_handle" do
				subject { model.get_active_window_handle }

				let(:query_args) { [:WinGetHandle, ["[active]"]] }

				it { should == result }
			end

			describe "#get_active_window_title" do
				subject { model.get_active_window_title }

				let(:query_args) { [:WinGetTitle, ["[active]"]] } 

				it { should == result }
			end

			describe "#get_active_window_text" do
				subject { model.get_active_window_text }

				let(:query_args) { [:WinGetText, ["[active]"]] }

				it { should == result }
			end

			describe "#get_control_text" do
				subject { model.get_control_text control_id }

				let(:control_id) { "[CLASS:_theControl]" }
				let(:query_args) { [:ControlGetText, ["[active]", "", control_id]] }

				it { should == result }
			end

			describe "#window_exist?" do
				subject { model.window_exist? window_title }

				let(:window_title) { 'window title' }
				let(:query_args) { [:WinExists, [window_title]] }

				context "when exist" do
					let(:result) { 1 }
					it { should be_true }
				end

				context "when NOT exist" do
					let(:result) { 0 }
					it { should be_false }
				end
			end
		end
	end
end

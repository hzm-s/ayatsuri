require 'spec_helper'

module Ayatsuri
	class Driver
		describe ModifierMethods do
			let(:model) { Object.new.extend(described_class) }

			before do
				model.stub(:modify).with(*modify_args) { true }
			end

			describe "#close_window" do
				subject { model.close_window "window title" }

				let(:modify_args) { [:WinClose, ["window title"]] }

				it { should be_true }
			end
		end
	end
end

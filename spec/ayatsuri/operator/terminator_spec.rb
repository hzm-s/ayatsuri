require 'spec_helper'

module Ayatsuri
	class Operator
		describe Terminator do
			let(:model) { Object.new.extend(described_class) }

			describe "#quit_application" do
				subject { model.quit_application }

				before do
					model.stub(:window_history) { window_history }
					window_history.stub(:uniq) { uniq }
				end

				let(:window_history) { mock 'window history' }
				let(:uniq) { mock 'unique windows' }

				it "calls close_windows" do
					model.should_receive(:close_windows).with(uniq)
					subject
				end
			end
		end
	end
end

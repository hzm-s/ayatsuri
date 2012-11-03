require 'spec_helper'

module Ayatsuri
	class Application
		class ActiveWindow
			describe Dispatcher do
				let(:model) { described_class.new active_window_change }
	
				let(:active_window_change) { mock 'active window change' }
				let(:operator) { mock 'operator' }
	
				describe "#start" do
					subject { model.start operator }

					before do
						active_window_change.stub(:next) { active_window }
					end

					let(:active_window) { mock 'active window' }

					context "when complete operation order" do
						before do
							operator.should_receive(:completed?).and_return(false, false, true)
							operator.should_receive(:assign).with(active_window).and_return(true, true)
						end

						it "dispatches next active window to operator until operator completed" do
							subject
						end
					end

					context "when failed operation" do
						before do
							operator.stub(:completed?).and_return(false, false, false, true)
							operator.stub(:assign).with(active_window).and_raise(AyatsuriError)
						end

						it { expect { subject }.to raise_error(Ayatsuri::AbortOperationOrder) }
					end
				end
			end
		end
	end
end

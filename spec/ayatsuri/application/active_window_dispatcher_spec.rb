require 'spec_helper'

module Ayatsuri
	class Application
		class ActiveWindow
			describe Dispatcher do
				let(:model) { described_class.new starter }
	
				let(:starter) { mock 'application starter' }
				let(:operator) { mock 'operator' }
	
				describe "#start" do
					subject { model.start operator }

					let(:active_window) { mock 'active window' }

					it "starts sequence" do
						ActiveWindow.should_receive(:init) { active_window }
						starter.should_receive(:start)
						model.should_receive(:execute_dispatch_loop).with(active_window)
						subject
					end
				end
			end
		end
	end
end

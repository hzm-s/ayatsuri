require 'spec_helper'

module Ayatsuri
	class Application
		describe Process do
			let(:model) { described_class.new starter, operator }

			let(:starter) { mock 'application starter' }
			let(:operator) { mock 'operator' }

			describe "#run" do
				subject { model.run }

				before do
					ActiveWindow::Dispatcher.stub(:new).with(starter) { dispatcher }
				end

				let(:dispatcher) { 'active window dispatcher' }
				let(:start_dispatch) { dispatcher.should_receive(:start).with(operator) }

				context "when successful" do
					before do
						start_dispatch.and_return(true)
					end
					it { should be_true }
				end
			end
		end
	end
end

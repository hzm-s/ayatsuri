require 'spec_helper'

module Ayatsuri
	class Application
		class ActiveWindow
			describe Dispatcher do
				let(:model) { described_class.new active_window_change, operation_order }
	
				let(:active_window_change) { mock 'active window change' }
				let(:operation_order) { mock 'operation order' }
				let(:operator) { mock 'operator' }
	
				describe "#start" do
					subject { model.start operator }

					let(:stub_assign) do
						model.stub(:assign_operation).with(operator)
					end

					context "when complete operation order" do
						before do
							operator.should_receive(:completed?).and_return(false, false, true)
							stub_assign.and_return(true, true)
						end

						it "assigns next active window to operator until operator completed" do
							subject
						end
					end

					context "when failed operation" do
						before do
							operator.stub(:completed?).and_return(false, false, false, true)
							stub_assign.and_raise(AyatsuriError)
						end

						it { expect { subject }.to raise_error(Ayatsuri::AbortOperationOrder) }
					end
				end

				describe "#assign_operation" do
					subject { model.assign_operation operator }

					before do
						model.stub(:retrieve_operation_by_active_window) { operation }
					end

					let(:active_window) { mock 'active window' }
					let(:operation) { mock 'operation' }

					it "assigns operation to operator" do
						operator.should_receive(:assign).with(operation)
						subject
					end
				end

				describe "#retrieve_operation_by_active_window" do
					subject { model.retrieve_operation_by_active_window }

					before do
						active_window_change.stub(:next) { active_window }
						operation_order.stub(:retrieve).with(active_window) { operation }
					end

					let(:active_window) { mock 'active window' }
					let(:operation) { mock 'operation' }

					it { should == operation }
				end
			end
		end
	end
end

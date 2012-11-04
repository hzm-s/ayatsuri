require 'spec_helper'

Ayatsuri::Waitable.interval = 0.1

def fake_window(active_window_pool)
	fiber = Fiber.new do
		active_window_pool.each do |active_window|
			Fiber.yield(active_window)
		end
		raise Ayatsuri::Timeout
	end
	Ayatsuri::Application::Window.stub(:active) { fiber.resume }
end

module Ayatsuri
	class Application
		class ActiveWindow
			describe Change do

				describe ".init" do
					subject { described_class.init }

					before { fake_window([:initial_window]) }

					it { subject.last.should == :initial_window }
				end

				describe "#next" do
					before do
						fake_window([:win0, :win0, :win1, :win2, :win2, :win2, :win3, :win2, :win2, :win1])
						@model = described_class.init
					end

					it "retrieves next active window change" do
						@model.next.should == :win1
						@model.next.should == :win2
						@model.next.should == :win3
						@model.next.should == :win2
						@model.next.should == :win1
					end

					context "when active window never change" do
						before do
							fake_window([:win0, :win0, :win1, :win1, :win1])
							@model = described_class.init
							@model.next
						end

						it { expect { @model.next }.to raise_error(Ayatsuri::Timeout) }
					end
				end
			end
		end
	end
end

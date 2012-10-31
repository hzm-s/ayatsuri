require 'spec_helper'

module Ayatsuri
	describe Application do
	end
end
__END__
		let(:model) { described_class.new driver, exe_path }

		let(:driver) { mock 'driver' }
		let(:exe_path) { "application.exe" }

		describe "#run" do
			subject { model.run active_window }

			before do
				ActiveWindow.stub(:add_observer).with(model)
				driver.stub(:run).with(exe_path) { true }
				window_title_updator.stub(:continue)
			end

			it { should be_true }
		end
	end
end

shared_context "application_control" do

	let(:window) do
		double('window').tap do |d|
			d.stub(:driver) { driver }
			d.stub(:title) { window_title }
		end
	end

	let(:driver) { mock 'driver instance' }
	let(:window_title) { mock 'window title' }
	let(:control_id) { mock 'control id' }
end

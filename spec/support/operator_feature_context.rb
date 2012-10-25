shared_context "operator_feature" do
	let(:operator) { Object.new }
	let(:return_value) { mock 'return value from invoked adapter method' }

	before do
		operator.extend described_class
	end
end

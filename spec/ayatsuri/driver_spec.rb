require 'spec_helper'

module Ayatsuri
	describe Driver do
		let(:model) { described_class.instance }

		before do
			described_class.any_instance.stub(:ole) { ole }
		end

		let(:ole) { mock 'win32ole for autoit X3' }

		describe ".instance" do
			subject { described_class.instance }

			before do
				WIN32OLE.stub(:new).with('AutoItX3.Control') { ole }
			end

			it { should == model }
		end

		describe "#invoke" do
			subject { model.invoke method_name, args }

			let(:method_name) { :autoit_method }
			let(:args) { [:arg1, :arg2, :arg3] }

			before do
				ole.should_receive(:send).with(method_name, *args) { result }
			end

			context "when successful" do
				let(:result) { true }
				it { should be_true }
			end

			context "when failed" do
				let(:result) { raise RuntimeError }
				it { expect { subject }.to raise_error(Ayatsuri::FailedToOperate) }
			end
		end
	end
end

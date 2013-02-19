require 'spec_helper'

module Ayatsuri
	describe Driver do
		let(:model) { described_class.instance }

		before do
			described_class.any_instance.stub(:ole) { stub_ole }
			described_class.any_instance.stub(:after_init) { nil }
		end

		after { described_class.flush }

		let(:stub_ole) do
			double('win32ole for autoit X3')
		end

		describe ".instance" do
			subject { described_class.instance }

			before do
				WIN32OLE.stub(:new).with('AutoItX3.Control') { stub_ole }
			end

			it { should == model }
		end

		describe ".new" do
			subject { described_class.new }
			it { expect { subject }.to raise_error(NoMethodError) }
		end

		describe "#invoke" do
			subject { model.invoke method_name, args }

			let(:method_name) { :autoit_method }
			let(:args) { [:arg1, :arg2, :arg3] }

			before do
				stub_ole.should_receive(:send).with(method_name, *args) { result }
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

		describe "#run_application" do
			subject { model.run_application exe_path }
			
			let(:exe_path) { mock '/path/to/application.exe' }

			it "invokes Run" do
				model.should_receive(:invoke).with(:Run, [exe_path])
				subject
			end
		end
	end
end

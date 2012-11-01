require 'spec_helper'

module Ayatsuri
	class Driver
		
		describe QueryMethods do
			let(:model) { Object.new.extend(described_class) }

			before do
				model.stub(:ole) { stub_ole }
				raw_string.stub(:encode) { encoded_string }
			end

			let(:stub_ole) { mock 'ole for autoit' }
			let(:raw_string) { mock 'raw string' }
			let(:encoded_string) { mock 'encoded string' }

			let(:control_id) { mock 'control id' }

			describe ".encoding=" do
				subject { described_class.encoding = enc }
				let(:enc) { Encoding::UTF_8 }
				it { subject; Encoding.default_internal.should == enc }
			end

			describe "#get_active_window_title" do
				subject { model.get_active_window_title }
				before do
					stub_ole.stub(:WinGetTitle).with("[active]") { raw_string }
				end
				it { should == encoded_string }
			end

			describe "#get_active_window_handle" do
				subject { model.get_active_window_handle }
				before { stub_ole.stub(:WinGetHandle).with("[active]") { raw_string } }
				it { should == raw_string }
			end

			describe "#get_active_window_text" do
				subject { model.get_active_window_text }
				before { stub_ole.stub(:WinGetText).with("[active]") { raw_string } }
				it { should == encoded_string }
			end

			describe "#get_control_text" do
				subject { model.get_control_text control_id }
				before { stub_ole.stub(:ControlGetText).with("[active]", "", control_id) { raw_string } }
				it { should == encoded_string }
			end
		end
	end

	describe Driver do
		let(:model) { described_class.instance }

		before do
			described_class.any_instance.stub(:ole) { stub_ole }
		end

		after { described_class.flush }

		let(:stub_ole) { mock 'win32ole for autoit X3' }

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
	end
end

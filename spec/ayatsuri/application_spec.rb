require 'spec_helper'

module Ayatsuri
	describe Application do
		let(:klass) { described_class }

		describe ".ayatsuri_for" do
			subject { klass.ayatsuri_for exe_path, starter_name }

			let(:exe_path) { 'C:\Program Files\app.exe' }
			let(:starter_name) { :clickonce }

			before do
				Application::Starter.stub(:create).with(exe_path, starter_name) { starter }
			end

			let(:starter) { mock 'application starter' }

			it { subject; klass.starter.should == starter }
		end

		describe ".operation_index" do
			subject { klass.define_operation_index FakeOperation, &index_block }

			let(:index_block) { lambda { "define operation index" } }

			before do
				stub_const("FakeOperation", Class.new)
				Operation::Index.stub(:build).with(&index_block).and_return(operation_index)
			end

			let(:operation_index) { mock 'operation index' }

			it { subject; klass.operation_index.should == operation_index }
		end
	end
end

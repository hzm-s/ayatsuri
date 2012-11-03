require 'spec_helper'

module Ayatsuri
	class Driver
		describe EncodeHelper do
			let(:model) { Object.new.extend(described_class) }

			describe "#encode_for_driver" do
				subject { model.encode_for_driver "a" }
				it { subject.encoding.should == Encoding::WINDOWS_31J }

				context "given as Array" do
					subject { model.encode_for_driver %w|a b c| }
					it { subject.all? {|s| s.encoding == Encoding::WINDOWS_31J }.should be_true }
				end
			end

			describe "#encode_for_ayatsuri" do
				subject { model.encode_for_ayatsuri "a" }
				it { subject.encoding.should == Encoding::UTF_8 }

				context "given as Array" do
					subject { model.encode_for_ayatsuri %w|a b c| }
					it { subject.all? {|s| s.encoding == Encoding::UTF_8 }.should be_true }
				end
			end
		end
	end
end

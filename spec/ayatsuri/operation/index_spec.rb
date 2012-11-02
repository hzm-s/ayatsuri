require 'spec_helper'

__END__
module Ayatsuri
	class Operation
		describe Index do
		end
	end
end

			describe ".build" do
				subject { described_class.build &index_block }

				let(:index_block) { lambda { "define index block" } }

				before do
					described_class.stub(:instance_eval).with(&index_block).and_return(built_index)
				end

				let(:built_index) { mock 'built index' }

				it { should == built_index }
			end

			describe ".window_title" do
				subject { described_class.window_title matcher, delegate_method }

				let(:matcher) { mock 'window matcher' }
				let(:delegate_method) { :method_for_match_window }

				before do
					WindowTitleMatcher.stub(:new).with(matcher) { matcher }
					described_class.any_instance.stub(:add).with(matcher, delegate_method)
				end

				let(:matcher) { mock 'matcher' }

				it { should == index }
			end
		end
	end
end

require 'spec_helper'
require 'ayatsuri/component/behavior/containable'

module Ayatsuri
	module Component
		module Behavior
			describe Containable do
				let(:mod) { described_class }

				before { stub_const("Ayatsuri::Component::Fake", Class.new) }

				describe "include" do
					subject { Fake.extend(mod).new }

					it { subject.child_repository.should == child_repository }
				end

				describe "#append_child" do
					subject { mod.append_child name, child }

					let(:name) { "child_name" }
					let(:child) { mock 'child component' }
				end
			end
		end
	end
end

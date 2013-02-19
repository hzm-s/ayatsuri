require 'spec_helper'

module Ayatsuri
	class Application
		describe Coordinate do
			include_context "application_control"

			let(:model) { described_class.new window, x, y }

			let(:x) { 200 }
			let(:y) { 100 }

			describe "#click" do
				subject { model.click button }

				let(:button) { :left }

				before do
					driver.stub(:click_coordinate).with(button.to_s, x, y, 1) { true }
				end

				it { should be_true }
			end
		end
	end
end

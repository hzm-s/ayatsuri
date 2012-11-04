require 'spec_helper'
require 'ie'

describe "IE Automation" do
	let(:ie) { IE.new }

	describe "#save_seach_result" do
		subject { ie.save_search_result keyword, save_path }

		let(:keyword) { "ayatsuri" }
		let(:save_path) { File.join(File.dirname(__FILE__), "search_result_#{keyword}.html") }

		it { File.exist?(subject).should be_true }
	end
end

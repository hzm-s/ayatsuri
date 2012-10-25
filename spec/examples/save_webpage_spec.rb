require 'spec_helper'
require 'firefox'

describe "Firefox Automation" do
	let(:ff) { Firefox.new }

	describe "#save_seach_result" do
		subject { ff.save_search_result keyword, save_path }

		let(:keyword) { "firefox" }
		let(:save_path) { File.join(File.dirname(__FILE__), "search_result_for#{keyword}.html") }

		it { File.exist?(subject).should be_true }
	end
end

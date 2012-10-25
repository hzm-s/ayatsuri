require 'spec_helper'
__END__
require 'calc'

describe "calculate by windows calc.exe" do
	let(:app) { Calc.new }

	context "given 1 + 2" do
		subject { app.calculate "1 + 2" }
		it { should == 3 }
	end
end

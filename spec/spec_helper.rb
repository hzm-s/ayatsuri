%w{lib examples}.each do |dir|
	$LOAD_PATH << File.join(File.dirname(__FILE__), '..', dir)
end

require 'pp'
require 'ayatsuri'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

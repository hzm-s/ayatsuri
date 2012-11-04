$LOAD_PATH << File.join(File.dirname(__FILE__), 'ayatsuri')

require 'errors'

module Ayatsuri
	autoload :Application,	'application'
	autoload :Driver,				'driver'
	autoload :Operation,		'operation'
	autoload :Operator,			'operator'
	autoload :Waitable,			'wait'

	class Interval
		@application_monitor	= 1
		@skip_operate					= 0.5

		class << self
			attr_accessor :application_monitor,
										:skip_operate
		end
	end
end

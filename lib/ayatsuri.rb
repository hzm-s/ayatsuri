require 'ayatsuri/version'
require 'ayatsuri/errors'

module Ayatsuri
	autoload :Application,	'ayatsuri/application'
	autoload :Driver,				'ayatsuri/driver'
	autoload :Operation,		'ayatsuri/operation'
	autoload :Operator,			'ayatsuri/operator'
	autoload :Waitable,			'ayatsuri/wait'

	class Interval
		@application_monitor	= 1
		@skip_operate					= 0.5

		class << self
			attr_accessor :application_monitor,
										:skip_operate
		end
	end
end

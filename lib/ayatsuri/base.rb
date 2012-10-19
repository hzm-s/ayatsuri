require 'ayatsuri/application'
require 'ayatsuri/driver'
require 'ayatsuri/component'

module Ayatsuri
	class Base

		class << self
			attr_reader :application

			def ayatsuri_for(application_id, root_window_id, &build_block)
				@application = Application.create(:autoit, application_id)
				@application.build_root_window(root_window_id, &build_block)
				self
			end
		end
	end
end

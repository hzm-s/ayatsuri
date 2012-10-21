require 'ayatsuri/application'
require 'ayatsuri/driver'
require 'ayatsuri/component'

module Ayatsuri
	class Base

		class << self
			attr_reader :application

			def ayatsuri_for(application_id, root_window_id, &create_component_block)
				@application = Application.create(:autoit, application_id)
				@application.create_root_window(root_window_id, &create_component_block)
				self
			end
		end
	end
end

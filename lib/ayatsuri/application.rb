module Ayatsuri
	class Application

		class << self

			def create(adapter, id)
				new(Driver.create(adapter), id)
			end
		end

		attr_reader :driver, :id, :root_window

		def initialize(driver, id)
			@driver, @id = driver, id
		end

		def create_root_window(id, &create_child_block)
			Component.create(:window, driver, nil, id).tap do |root_window|
				if create_child_block
					@root_window = Component.build(root_window, &create_child_block)
				else
					@root_window = root_window
				end
			end
			self
		end
	end
end
__END__

		class << self
			attr_reader :application, :driver

			RootWindow = Struct.new("RootWindow", :name, :window)

			def inherited(child_class)
				child_class.initialize_application
				super
			end

			def initialize_application
				self.instance_variable_set(:@application, nil)
				self.instance_variable_set(:@driver, nil)
				self.instance_variable_set(:@root_window, nil)
			end

			def ayatsuri_for(application, root_window_identifier, &build_block)
				@application = application
				@driver = Driver.create("autoit")
				builder = Component::Builder.new(@driver, self)
				builder.window("root", root_window_identifier, &build_block)
				self
			end

			def root_window
				@root_window.window
			end

			def append_child(name, child)
				@root_window = RootWindow.new(name, child)
				child
			end
		end

		def boot!(&operate_block)
			self.class.tap {|klass| klass.driver.boot!(klass.application) }
			operate(&operate_block) if operate_block
		rescue => exception
			raise exception
		end

		def method_missing(method, *args, &block)
			super unless Component.available_type?(method)
			self.class.root_window.find_child(method, args[0])
		end

	private

		def operate(&block)
			self.instance_exec(&block)
		rescue => exception
			raise exception
		ensure
			self.class.tap {|klass| klass.driver.shutdown!(klass.root_window) }
		end
	end
end

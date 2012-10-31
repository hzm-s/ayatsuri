require 'win32ole'

module Ayatsuri
	module AutomationAdapter
		class Autoit

			KEYNAME_MAP = {
				alt:		"!",
				win:		"#",
				shift:	"+",
				ctrl:		"^",
				tab:		"{TAB}",
				enter:	"{ENTER}",
				space:	"{SPACE}",
				up:			"{UP}",
				down:		"{DOWN}",
				left:		"{LEFT}",
				right:	"{RIGHT}",
				bs:			"{BS}",
				del:		"{DEL}",
				esc:		"{ESC}"
			}

			def initialize
				@ole = WIN32OLE.new('AutoItX3.Control')
			end

			def run_application(exe_path)
				@ole.Run(exe_path)
				true
			end

			def input(keys)
				@ole.Send(keys)
				true
			end

			def keyname_resolver(keyname)
				keyname.to_s.gsub(/#{KEYNAME_MAP.keys}/)
				keyname.to_s.scan(/[a-z]+/) {|name| KEYNAME_MAP[name] }
			end
		end
	end
end

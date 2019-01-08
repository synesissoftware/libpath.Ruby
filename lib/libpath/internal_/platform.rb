
module LibPath
module Internal_

module Platform

	module OS_Internal_

		def self.win_platform_?

			return true if 'Windows_NT' == ENV['OS']

			[
				'bccwin',
				'cygwin',
				'djgpp',
				'mingw',
				'mswin',
				'wince',
			].each do |os_name|

				return true if /#{os_name}/i =~ RUBY_PLATFORM
			end

			false
		end

	end # module OS_Internal_

	module Constants

		PLATFORM_IS_WINDOWS	=	OS_Internal_.win_platform_?

	end # module Constants

end # module Platform

end # module Internal_
end # module LibPath

# ############################## end of file ############################# #



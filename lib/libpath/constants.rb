
require 'libpath/internal_/platform'

if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

	require 'libpath/constants/windows'
else

	require 'libpath/constants/unix'
end

module LibPath
module Constants

	if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

		extend ::LibPath::Constants::Windows
		include ::LibPath::Constants::Windows
	else

		extend ::LibPath::Constants::Unix
		include ::LibPath::Constants::Unix
	end

	def self.extended receiver

		$stderr.puts "#{receiver} extended by #{self}" if $DEBUG
	end

	def self.included receiver

		$stderr.puts "#{receiver} included #{self}" if $DEBUG
	end

end # module Constants
end # module LibPath

# ############################## end of file ############################# #




require 'libpath/internal_/platform'

if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

	require 'libpath/constants/windows'
else

	require 'libpath/constants/unix'
end

module LibPath # :nodoc:
module Constants # :nodoc:

	if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

		extend ::LibPath::Constants::Windows
		include ::LibPath::Constants::Windows
	else

		extend ::LibPath::Constants::Unix
		include ::LibPath::Constants::Unix
	end

	# @!visibility private
	def self.extended receiver # :nodoc:

		$stderr.puts "#{receiver} extended by #{self}" if $DEBUG
	end

	# @!visibility private
	def self.included receiver # :nodoc:

		$stderr.puts "#{receiver} included #{self}" if $DEBUG
	end

end # module Constants
end # module LibPath

# ############################## end of file ############################# #



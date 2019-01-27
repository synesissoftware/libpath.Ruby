
require 'libpath/internal_/platform'

if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

	require 'libpath/path/windows'
else

	require 'libpath/path/unix'
end

module LibPath
module Path

	if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

		extend ::LibPath::Path::Windows
		include ::LibPath::Path::Windows
	else

		extend ::LibPath::Path::Unix
		include ::LibPath::Path::Unix
	end

end # module Path
end # module LibPath

# ############################## end of file ############################# #




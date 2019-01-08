
require 'libpath/internal_/platform'

if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

	require 'libpath/form/windows'
else

	require 'libpath/form/unix'
end

module LibPath
module Form

	if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

		extend ::LibPath::Form::Windows
		include ::LibPath::Form::Windows
	else

		extend ::LibPath::Form::Unix
		include ::LibPath::Form::Unix
	end

end # module Form
end # module LibPath

# ############################## end of file ############################# #



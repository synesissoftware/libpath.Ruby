
require 'libpath/internal_/platform'

if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

  require 'libpath/path/windows'
else

  require 'libpath/path/unix'
end


module LibPath
# @!visibility private
module Path # :nodoc:

  if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

    extend ::LibPath::Path::Windows
    include ::LibPath::Path::Windows
  else

    extend ::LibPath::Path::Unix
    include ::LibPath::Path::Unix
  end

  # @!visibility private
  def self.extended receiver # :nodoc:

    $stderr.puts "#{receiver} extended by #{self}" if $DEBUG
  end

  # @!visibility private
  def self.included receiver # :nodoc:

    $stderr.puts "#{receiver} included #{self}" if $DEBUG
  end
end # module Path
end # module LibPath


# ############################## end of file ############################# #


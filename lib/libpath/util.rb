
require 'libpath/internal_/platform'

if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

  require 'libpath/util/windows'
else

  require 'libpath/util/unix'
end

module LibPath # :nodoc:
module Util # :nodoc:

  if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

    extend ::LibPath::Util::Windows
    include ::LibPath::Util::Windows
  else

    extend ::LibPath::Util::Unix
    include ::LibPath::Util::Unix
  end

  # @!visibility private
  def self.extended receiver # :nodoc:

    $stderr.puts "#{receiver} extended by #{self}" if $DEBUG
  end

  # @!visibility private
  def self.included receiver # :nodoc:

    $stderr.puts "#{receiver} included #{self}" if $DEBUG
  end
end # module Util
end # module LibPath


# ############################## end of file ############################# #


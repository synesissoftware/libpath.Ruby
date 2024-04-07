
# :stopdoc:


module LibPath
# @!visibility private
module Internal_ # :nodoc: all

  # @!visibility private
  module Platform # :nodoc: all

    # @!visibility private
    module OS_Internal_ # :nodoc: all

      # @!visibility private
      def self.win_platform_? # :nodoc:

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

    # @!visibility private
    module Constants # :nodoc: all

      # @!visibility private
      PLATFORM_IS_WINDOWS = OS_Internal_.win_platform_? # :nodoc:

    end # module Constants
  end # module Platform
end # module Internal_
end # module LibPath


# :startdoc:


# ############################## end of file ############################# #


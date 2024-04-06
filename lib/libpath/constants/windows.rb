# ######################################################################## #
# File:     libpath/constants/windows.rb
#
# Purpose:  LibPath::Constants::Windows module
#
# Created:  29th January 2019
# Updated:  6th April 2024
#
# Home:     http://github.com/synesissoftware/libpath.Ruby
#
# Author:   Matthew Wilson
#
# Copyright (c) 2019-2024, Matthew Wilson and Synesis Information Systems
# Copyright (c) 2019, Matthew Wilson and Synesis Software
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# * Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the distribution.
#
# * Neither the names of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# ######################################################################## #


=begin
=end

module LibPath # :nodoc:
module Constants # :nodoc:
module Windows # :nodoc:

# Module defining instance functions that will be included and extended into
# any class or module including/extending module LibPath::Constants::Windows
module LibPath_Constants_Windows_Details

  # Defines invalid characters
  module InvalidCharacters

    # Innately invalid characters
    module Innate

      # The list of characters
      LIST = [

        "\0",
      ]
      # The regular expression
      RE = /[#{LIST.map { |m| Regexp.escape m }.join}]/
    end # module Innate

    # Valid path name separator characters
    module PathNameSeparators

      # The list of characters
      LIST = [

        "\\",
        '/',
      ]
      # The regular expression
      RE = /[#{LIST.map { |m| Regexp.escape m }.join}]/
    end # module PathNameSeparators

    # Valid path separator characters
    module PathSeparators

      # The list of characters
      LIST = [

        ';',
      ]
      # The regular expression
      RE = /[#{LIST.map { |m| Regexp.escape m }.join}]/
    end # module PathSeparators

    # Invalid shell characters
    module Shell

      # The list of characters
      LIST = [

        '*',
        '<',
        '>',
        '?',
        '|',
      ]
      # The regular expression
      RE = /[#{LIST.map { |m| Regexp.escape m }.join}]/
    end # module Shell
  end # module InvalidCharacters
end # module LibPath_Constants_Windows_Details

# @!visibility private
def self.extended receiver # :nodoc:

  receiver.class_eval do

    extend LibPath_Constants_Windows_Details
  end

  $stderr.puts "#{receiver} extended by #{LibPath_Constants_Windows_Details}" if $DEBUG
end

# @!visibility private
def self.included receiver # :nodoc:

  receiver.class_eval do

    include LibPath_Constants_Windows_Details
  end

  $stderr.puts "#{receiver} included #{LibPath_Constants_Windows_Details}" if $DEBUG
end

extend LibPath_Constants_Windows_Details
include LibPath_Constants_Windows_Details

end # module Windows
end # module Constants
end # module LibPath


# ############################## end of file ############################# #


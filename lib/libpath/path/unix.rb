
# ######################################################################## #
# File:     libpath/path/unix.rb
#
# Purpose:  LibPath::Path::Unix module
#
# Created:  21st January 2019
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

require 'libpath/diagnostics'
require 'libpath/internal_/unix/form'
require 'libpath/util/unix'


module LibPath # :nodoc:
module Path # :nodoc:
module Unix # :nodoc:

  # Class representing a parsed path (for UNIX)
  class ParsedPath

    # @!visibility private
    module ParsedPath_Constants # :nodoc: all

      INIT_VALID_OPTIONS      = %i{ home locator pwd }
      INIT_MPA_COMMON_OPTIONS = %i{ home locator pwd }
      INIT_DRP_COMMON_OPTIONS = %i{ home locator pwd }
    end

    # Initialises an instance from the given +path+, optional
    # +search_directory+ and options
    #
    # === Signature
    #
    # * *Parameters:*
    #   - +path+ (String) The path. May not be +nil+
    #   - +search_directory+ (String) The search_directory, from which the relative attributes are calculated for the path. May be +nil+
    #   - +options+ (Hash) Options
    #
    # * *Options:*
    #   - +????+
    #
    # * *Exceptions:*
    #   - +ArgumentError+ Raised if +path+ is +nil+
    def initialize path, search_directory = nil, **options

      raise ::ArgumentError, "path may not be nil or empty" if path.nil? || path.empty?

      _Diagnostics    = ::LibPath::Diagnostics
      _Internal_Form  = ::LibPath::Internal_::Unix::Form
      _Util           = ::LibPath::Util::Unix
      _C              = ::LibPath::Path::Unix::ParsedPath::ParsedPath_Constants

      _Diagnostics.check_options(options, known: _C::INIT_VALID_OPTIONS)


      abs_path = _Util.make_path_absolute(path, make_canonical: true, **options.select { |k| _C::INIT_MPA_COMMON_OPTIONS.include?(k) })

      _, _, f2_dir, f3_basename, f4_stem, f5_ext, f6_dir_parts, _ = _Internal_Form.split_path(abs_path)

      @given_path       = path
      @absolute_path    = abs_path
      @compare_path     = _Util.make_compare_path abs_path
      @directory        = f2_dir
      @directory_path   = f2_dir
      @directory_parts  = f6_dir_parts

      @file_full_name   = f3_basename
      @file_name_only   = f4_stem
      @file_extension   = f5_ext

      if search_directory

        drp_options                       = options.select { |k| _C::INIT_DRP_COMMON_OPTIONS.include?(k) }

        search_directory                  = _Util.make_path_absolute(search_directory, make_canonical: true, **options.select { |k| _C::INIT_MPA_COMMON_OPTIONS.include?(k) })
        search_directory                  = _Internal_Form.append_trailing_slash search_directory

        @search_directory                 = search_directory
        @search_relative_path             = _Util.derive_relative_path(search_directory, abs_path, **drp_options)
        @search_relative_path             = _Internal_Form.append_trailing_slash(@search_relative_path) if _Internal_Form.char_is_path_name_separator?(abs_path[-1])
        @search_relative_directory_path   = _Internal_Form.append_trailing_slash _Util.derive_relative_path(search_directory, f2_dir, **drp_options)
        @search_relative_directory_parts  = @search_relative_directory_path.split('/').map { |v| v + '/' }
      end
    end

    # (String) The path given to initialise the instance
    attr_reader :given_path
    # (String) The full-path of the instance
    attr_reader :absolute_path
    # (String) A normalised form of #path that can be used in comparisons
    attr_reader :compare_path
    # (String) The entry's directory (excluding the #drive if on Windows)
    attr_reader :directory
    # (String) The full path of the entry's directory
    attr_reader :directory_path
    alias_method :dirname, :directory_path
    # ([String]) An array of directory parts, where each part ends in the path name separator
    attr_reader :directory_parts
    # (String) The entry's file name (combination of #stem + #extension)
    attr_reader :file_full_name
    alias_method :basename, :file_full_name
    # (String) The entry's file stem
    attr_reader :file_name_only
    alias_method :stem, :file_name_only
    # (String) The entry's file extension
    attr_reader :file_extension
    alias_method :extension, :file_extension
    # (String) The search directory if specified; +nil+ otherwise
    attr_reader :search_directory
    # (String) The #path relative to #search_directory; +nil+ if no search directory specified
    attr_reader :search_relative_path
    # (String) The #directory_path relative to #search_directory; +nil+ if no search directory specified
    attr_reader :search_relative_directory_path
    # ([String]) The #directory_parts relative to #search_directory; +nil+ if no search directory specified
    attr_reader :search_relative_directory_parts

    # (String) String form of path
    def to_s

      absolute_path
    end
  end

end # module Unix
end # module Path
end # module LibPath


# ############################## end of file ############################# #


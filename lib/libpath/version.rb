# ######################################################################## #
# File:     libpath/version.rb
#
# Purpose:  Version for libpath.Ruby library
#
# Created:  8th January 2019
# Updated:  13th April 2024
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

module LibPath

  # Current version of the libpath.Ruby library
  VERSION           = '0.2.2.3'

  private
  # @!visibility private
  VERSION_PARTS_    = VERSION.split(/[.]/).collect { |n| n.to_i } # :nodoc:
  public
  # Major version of the libpath.Ruby library
  VERSION_MAJOR     = VERSION_PARTS_[0]
  # Minor version of the libpath.Ruby library
  VERSION_MINOR     = VERSION_PARTS_[1]
  # Patch version of the libpath.Ruby library
  VERSION_PATCH     = VERSION_PARTS_[2]
  # Revision version of the libpath.Ruby library
  VERSION_REVISION  = VERSION_PATCH
  # Sub-patch version of the libpath.Ruby library
  VERSION_SUBPATCH  = VERSION_PARTS_[3]
end # module LibPath


# ############################## end of file ############################# #


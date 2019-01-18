
# ######################################################################## #
# File:         libpath/util/windows.rb
#
# Purpose:      LibPath::Util::Windows module
#
# Created:      10th January 2019
# Updated:      19th January 2018
#
# Home:         http://github.com/synesissoftware/libpath.Ruby
#
# Author:       Matthew Wilson
#
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
require 'libpath/internal_/array'
require 'libpath/internal_/windows/form'

module LibPath
module Util
module Windows

# Module defining instance functions that will be included and extended into
# any class or module including/extending module LibPath::Util::Windows
module LibPath_Util_Windows_Methods

	# Converts a path into canonical form, which is to say that all possible
	# dots directory parts are removed:
	#
	# - single-dot parts - './' or '.\\' - are all removed
	# - double-dot parts - '../' or '..\\' - are removed where they follow a
	#    non-dots directory part
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +path+:: (String) The path to be evaluated. May not be +nil+
	def make_path_canonical path

		Diagnostics.check_string_parameter(path, "path") if $DEBUG

		return path unless '.' == path[-1] || path.include?('./') || path.include?('.\\')

		_Form	=	::LibPath::Internal_::Windows::Form
		_Array	=	::LibPath::Internal_::Array

		_, f1_volume, f2_directory, f3_basename, _, _, f6_dir_parts, _ = _Form.split_path path

		return path if f6_dir_parts.empty?

		last_slash = nil

		case f3_basename
		when '.', '..'

			f6_dir_parts	<<	f3_basename + '\\'
			basename		=	nil
		when nil

			last_slash		=	_Form.get_trailing_slash(f2_directory) || '\\'
		else

			basename		=	f3_basename
		end

		new_parts	=	f6_dir_parts.reject { |p| './' == p }.reject { |p| '.\\' == p }
		ix_2dots	=	_Array.index2(new_parts, '../', '..\\')

		return path unless new_parts.size != f6_dir_parts.size || ix_2dots

		while (ix_2dots || 0) > 0

			new_parts.delete_at(ix_2dots - 0)
			new_parts.delete_at(ix_2dots - 1)

			ix_2dots = _Array.index2(new_parts, '../', '..\\')
		end

		if new_parts.empty? && (basename || '').empty?

			return '.' + last_slash.to_s
		end

		return f1_volume.to_s + new_parts.join('') + basename.to_s
	end
end # module LibPath_Util_Windows_Methods

def self.extended receiver

	receiver.class_eval do

		extend LibPath_Util_Windows_Methods
	end

	$stderr.puts "#{receiver} extended by #{LibPath_Util_Windows_Methods}" if $DEBUG
end

def self.included receiver

	receiver.class_eval do

		include LibPath_Util_Windows_Methods
	end

	$stderr.puts "#{receiver} included #{LibPath_Util_Windows_Methods}" if $DEBUG
end

extend LibPath_Util_Windows_Methods
include LibPath_Util_Windows_Methods

end # module Windows
end # module Util
end # module LibPath

# ############################## end of file ############################# #



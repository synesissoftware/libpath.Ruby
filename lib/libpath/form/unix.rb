
# ######################################################################## #
# File:         libpath/form/unix.rb
#
# Purpose:      LibPath::Form::Unix module
#
# Created:      8th January 2019
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

module LibPath
module Form
module Unix

# Module defining instance functions that will be included and extended into
# any class or module including/extending module LibPath::Form::Unix
module LibPath_Form_Unix_Methods

	# Evaluates whether the given path is absolute, which means it is either
	# rooted (begins with '/') or is homed (is '~' or begins with '~/')
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +path+:: (String) The path to be evaluated. May not be +nil+
	def path_is_absolute? path

		Diagnostics.check_string_parameter(path, "path") if $DEBUG

		case path[0]
		when '/'

			true
		when '~'

			1 == path.size || '/' == path[1]
		else

			false
		end
	end

	# Evaluates whether the given path is homed, which means it is '~' or
	# begins with '~/'
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +path+:: (String) The path to be evaluated. May not be +nil+
	def path_is_homed? path

		Diagnostics.check_string_parameter(path, "path") if $DEBUG

		return false unless '~' == path[0]

		if path.size > 1

			return '/' == path[1]
		end

		true
	end

	# Evalutes whether the given path is rooted, which means it begins with
	# '/'
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +path+:: (String) The path to be evaluated. May not be +nil+
	def path_is_rooted? path

		Diagnostics.check_string_parameter(path, "path") if $DEBUG

		'/' == path[0]
	end

end # module LibPath_Form_Unix_Methods

def self.extended receiver

	receiver.class_eval do

		extend LibPath_Form_Unix_Methods
	end

	$stderr.puts "#{receiver} extended by #{LibPath_Form_Unix_Methods}" if $DEBUG
end

def self.included receiver

	receiver.class_eval do

		include LibPath_Form_Unix_Methods
	end

	$stderr.puts "#{receiver} included #{LibPath_Form_Unix_Methods}" if $DEBUG
end

extend LibPath_Form_Unix_Methods
include LibPath_Form_Unix_Methods

end # module Unix
end # module Form
end # module LibPath

# ############################## end of file ############################# #



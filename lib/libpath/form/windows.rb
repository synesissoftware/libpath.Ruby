
# ######################################################################## #
# File:         libpath/form/windows.rb
#
# Purpose:      LibPath::Form::Windows module
#
# Created:      8th January 2019
# Updated:      29th January 2018
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
require 'libpath/internal_/windows/drive'
require 'libpath/internal_/windows/form'

module LibPath
module Form
module Windows

module LibPath_Form_Windows_Methods

	# Classifies a path
	#
	# === Return
	#
	# One of +:absolute+, +:drived+, +:homed+, +:relative+, +:rooted+, for
	# any paths that match precisely those classifications, or +nil+ if the
	# path is empty
	def classify_path path

		Diagnostics.check_string_parameter(path, "path") if $DEBUG

		return nil if path.nil? || path.empty?

		return :homed if path_is_homed? path

		vol, rem, _ = Internal_::Windows::Form.get_windows_volume(path)

		rooted	=	Internal_::Windows::Form.char_is_path_name_separator? rem[0]

		if rooted

			if vol

				return :absolute
			else

				return :rooted
			end
		else

			if vol

				return :drived
			else

				return :relative
			end
		end

	end

	# Evaluates whether the given path is absolute, which means it is either
	# rooted (begins with '/') or is homed (is '~' or begins with '~/')
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +path+:: (String) The path to be evaluated. May not be +nil+
	def path_is_absolute? path

		Diagnostics.check_string_parameter(path, "path") if $DEBUG

		return true if path_is_homed? path

		vol, rem, _ = Internal_::Windows::Form.get_windows_volume(path)

		return false unless vol
		return false unless rem

		Internal_::Windows::Form.char_is_path_name_separator? rem[0]
	end

	# Evaluates whether the given path is "letter drived", which means that
	# it contains a drive specification. Given the two letter sequence 'X:'
	# representing any ASCII letter (a-zA-Z) and a colon, this function
	# recognises six sequences: +'X:'+, +'X:\'+, +'X:/'+, +'\\?\X:'+,
	# +'\\?\X:\'+, +'\\?\X:/'+
	#
	# === Return
	#  - +nil+:: if it is not "drived";
	#  - 2:: it begins with the form +'X:'+
	#  - 3:: it begins with the form +'X:\'+ or +'X:/'+
	#  - 6:: it begins with the form +'\\?\X:'+
	#  - 7:: it begins with the form +'\\?\X:\'+ or +'\\?\X:/'+
	def path_is_letter_drived? path

		Diagnostics.check_string_parameter(path, "path") if $DEBUG

		if path.size >= 2

			base_index	=	0

			if '\\' == path[0]

				if '\\' == path[1]

					if '?' == path[2]

						if '\\' == path[3]

							base_index = 4
						end
					end
				end
			end

			if ':' == path[base_index + 1]

				if Internal_::Windows::Drive.character_is_drive_letter? path[base_index + 0]

					if Internal_::Windows::Form.char_is_path_name_separator? path[base_index + 2]

						return 4 == base_index ? 7 : 3
					else

						return 4 == base_index ? 6 : 2
					end
				end
			end
		end

		nil
	end

	# Evaluates whether the given path is homed, which means it is '~' or
	# begins with '~/' or '~\'
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +path+:: (String) The path to be evaluated. May not be +nil+
	def path_is_homed? path

		Diagnostics.check_string_parameter(path, "path") if $DEBUG

		return false unless '~' == path[0]

		if path.size > 1

			return Internal_::Windows::Form.char_is_path_name_separator? path[1]
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

		case path[0]
		when '/'

			true
		when '\\'

			case path[1]
			when '\\'

				vol, rem, _ = Internal_::Windows::Form.get_windows_volume(path)

				return false unless vol

				if rem && Internal_::Windows::Form.char_is_path_name_separator?(rem[0])

					true
				else

					false
				end
			else

				true
			end
		else

			if path.size > 2

				if ':' == path[1]

					if Internal_::Windows::Drive.character_is_drive_letter? path[0]

						return Internal_::Windows::Form.char_is_path_name_separator? path[2]
					end
				end
			end

			false
		end
	end

	def path_is_UNC? path

		Diagnostics.check_string_parameter(path, "path") if $DEBUG

		return false unless '\\' == path[0]
		return false unless '\\' == path[1]

		_, _, frm = Internal_::Windows::Form.get_windows_volume(path)

		case frm
		when :form_2, :form_3, :form_4, :form_5, :form_6

			true
		else

			false
		end
	end

end # module LibPath_Form_Windows_Methods

def self.extended receiver

	receiver.class_eval do

		extend LibPath_Form_Windows_Methods
	end

	$stderr.puts "#{receiver} extended by #{LibPath_Form_Windows_Methods}" if $DEBUG
end

def self.included receiver

	receiver.class_eval do

		include LibPath_Form_Windows_Methods
	end

	$stderr.puts "#{receiver} included #{LibPath_Form_Windows_Methods}" if $DEBUG
end

extend LibPath_Form_Windows_Methods
include LibPath_Form_Windows_Methods

end # module Windows
end # module Form
end # module LibPath

# ############################## end of file ############################# #



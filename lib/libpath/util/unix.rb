
# ######################################################################## #
# File:         libpath/util/unix.rb
#
# Purpose:      LibPath::Util::Unix module
#
# Created:      14th January 2019
# Updated:      21st January 2018
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
require 'libpath/form/unix'
require 'libpath/internal_/unix/form'

module LibPath
module Util
module Unix

# Module defining instance functions that will be included and extended into
# any class or module including/extending module LibPath::Util::Unix
module LibPath_Util_Unix_Methods

	def combine_paths *args, **options

		_Form_Unix			=	Form::Unix
		_Internal_Unix_Form	=	Internal_::Unix::Form

		args.each_with_index { |arg, index| Diagnostics.check_string_parameter(arg, "arg#{index}", allow_nil: true) } if $DEBUG

		args	=	args.reject { |arg| arg.nil? || arg.empty? }

		case args.size
		when 0

			''
		when 1

			args[0]
		else

			rix	=	args.rindex { |arg| arg && _Form_Unix.path_is_absolute?(arg) }
			rix	||=	0

			els	=	args[rix..-1]

			File.join *els
		end
	end

	#
	# === Signature
	#
	#
	def derive_relative_path origin, path, **options

		return path if origin.nil? || origin.empty?
		return path if path.nil? || path.empty?

		_Form_Unix			=	Form::Unix
		_Util_Unix			=	Util::Unix
		_Internal_Unix_Form	=	Internal_::Unix::Form

		_MPA_COMMON_OPTIONS	=	%i{ home locator pwd }

		origin	=	_Util_Unix.make_path_canonical(origin)
		path	=	_Util_Unix.make_path_canonical(path)

		return '.' if origin == path
		return path if '.' == origin

		o_is_abs	=	_Form_Unix.path_is_absolute?(origin)
		p_is_abs	=	_Form_Unix.path_is_absolute?(path)

		if o_is_abs != p_is_abs || '.' == path

			origin	=	_Util_Unix.make_path_absolute(origin, make_canonical: true, **options.select { |k| _MPA_COMMON_OPTIONS.include?(k) })
			path	=	_Util_Unix.make_path_absolute(path, make_canonical: true, **options.select { |k| _MPA_COMMON_OPTIONS.include?(k) })
		end

		trailing_slash	=	_Internal_Unix_Form.get_trailing_slash(path)

		origin	=	_Internal_Unix_Form.trim_trailing_slash(origin) unless origin.size < 2
		path	=	_Internal_Unix_Form.trim_trailing_slash(path) unless path.size < 2


		_, _, o2_dir, o3_basename, _, _, o6_parts, _	=	_Internal_Unix_Form.split_path(origin)
		_, _, p2_dir, p3_basename, _, _, p6_parts, _	=	_Internal_Unix_Form.split_path(path)

		o_parts	=	o6_parts
		o_parts	<<	o3_basename if o3_basename && '.' != o3_basename

		p_parts	=	p6_parts
		p_parts	<<	p3_basename if p3_basename


		while true

			break if o_parts.empty?
			break if p_parts.empty?

			o_part	=	o_parts[0]
			p_part	=	p_parts[0]

			if 1 == o_parts.size || 1 == p_parts.size

				o_part	=	_Internal_Unix_Form.append_trailing_slash o_part
				p_part	=	_Internal_Unix_Form.append_trailing_slash p_part
			end

			if o_part == p_part

				o_parts.shift
				p_parts.shift
			else

				break
			end
		end


		return '.' if 0 == (o_parts.size + p_parts.size)

		return o_parts.map { |rp| '..' }.join('/') if p_parts.empty?


		ar		=	[ '..' ] * o_parts.size + p_parts
		last	=	ar.pop
		ar		=	ar.map { |el| _Internal_Unix_Form.append_trailing_slash(el) }

		ar.join + last.to_s
	end


	#
	# === Signature
	#
	# * *Parameters:*
	#   - +path+:: (String) The path to be evaluated. May not be +nil+
	#   - +options+:: (Hash) Options that moderate the behaviour of the
	#       function
	#
	# * *Options:*
	#   - +:home+:: (String) A specific home to assume, which means that the
	#       +locator+'s +home+ method will not be invoked
	#   - +:locator+:: (object) An object that provides the methods
	#       +pwd+ and +home+, as needed. This allows for mocking. If not
	#       given, then the functions +Dir::pwd+ and +Dir::home+ are used
	#   - +:make_canonical+:: (boolean) Determines whether canonicalisation
	#       is conducted on the result
	#   - +:pwd+:: (String) A specific directory to assume, which means that
	#       the +locator+'s +pwd+ method will not be invoked
	def make_path_absolute path, **options

		Diagnostics.check_string_parameter(path, "path") if $DEBUG
		Diagnostics.check_options(options, known: %i{ home locator make_canonical pwd }) if $DEBUG

		return path if path.nil? || path.empty?

		r	=	nil

		case path[0]
		when '/'

			r = path
		when '~'

			case path[1]
			when nil, '/'

				home	=	nil
				home	||=	options[:home]
				home	||=	options[:locator].home if options.has_key?(:locator)
				home	||=	Dir.home

				r = File.join(home, path[2..-1])
			end
		end

		unless r

			pwd	=	nil
			pwd	||=	options[:pwd]
			pwd	||=	options[:locator].pwd if options.has_key?(:locator)
			pwd	||=	Dir.pwd

			r = File.join(pwd, path)
		end

		r	||=	path

		r	=	make_path_canonical r if options[:make_canonical]

		return r
	end

	# Converts a path into canonical form, which is to say that all possible
	# dots directory parts are removed:
	#
	# - single-dot parts - './' - are all removed
	# - double-dot parts - '../' - are removed where they follow a non-dots
	#    directory part
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +path+:: (String) The path to be evaluated. May not be +nil+
	def make_path_canonical path

		Diagnostics.check_string_parameter(path, "path") if $DEBUG

		return path unless '.' == path[-1] || path.include?('./')

		_Form	=	::LibPath::Internal_::Unix::Form

		_, _, _, f3_basename, _, _, f6_dir_parts, _ = _Form.split_path path

		return path if f6_dir_parts.empty?

		case f3_basename
		when '.', '..'

			f6_dir_parts	<<	f3_basename + '/'
			basename		=	nil
		else

			basename		=	f3_basename
		end

		new_parts	=	f6_dir_parts.reject { |p| './' == p }
		ix_2dots	=	new_parts.index('../')

		return path unless new_parts.size != f6_dir_parts.size || ix_2dots

		while (ix_2dots || 0) > 0

			new_parts.delete_at(ix_2dots - 0)
			new_parts.delete_at(ix_2dots - 1)

			ix_2dots = new_parts.index('../')
		end

		if new_parts.empty? && (basename || '').empty?

			return f3_basename ? '.' : './'
		end

		return new_parts.join('') + basename.to_s
	end
end # module LibPath_Util_Unix_Methods

def self.extended receiver

	receiver.class_eval do

		extend LibPath_Util_Unix_Methods
	end

	$stderr.puts "#{receiver} extended by #{LibPath_Util_Unix_Methods}" if $DEBUG
end

def self.included receiver

	receiver.class_eval do

		include LibPath_Util_Unix_Methods
	end

	$stderr.puts "#{receiver} included #{LibPath_Util_Unix_Methods}" if $DEBUG
end

extend LibPath_Util_Unix_Methods
include LibPath_Util_Unix_Methods

end # module Unix
end # module Util
end # module LibPath

# ############################## end of file ############################# #



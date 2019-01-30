
# ######################################################################## #
# File:         libpath/util/windows.rb
#
# Purpose:      LibPath::Util::Windows module
#
# Created:      10th January 2019
# Updated:      30th January 2018
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
require 'libpath/form/windows'
require 'libpath/internal_/array'
require 'libpath/internal_/windows/form'

module LibPath
module Util
module Windows

# Module defining instance functions that will be included and extended into
# any class or module including/extending module LibPath::Util::Windows
module LibPath_Util_Windows_Methods

	def combine_paths *args, **options

		_Form_Windows			=	Form::Windows
		_Internal_Windows_Form	=	Internal_::Windows::Form

		args.each_with_index { |arg, index| Diagnostics.check_string_parameter(arg, "arg#{index}", allow_nil: true) } if $DEBUG

		first	=	[]
		dirs	=	[]
		last	=	[]

		if options[:elide_single_dots]

			args	=	args.map do |arg|

				case arg
				when '.', './'

					nil
				else

					arg
				end
			end
		end

		args	=	args.reject { |arg| arg.nil? || arg.empty? }

		rix_abs	=	nil
		rix_drv	=	nil
		rix_dir	=	nil

		args.each_with_index do |arg, index|

			vol, rem, _ = _Internal_Windows_Form.get_windows_volume arg

			rem = nil unless rem && _Internal_Windows_Form.char_is_path_name_separator?(rem[0])

			if vol

				if rem

					rix_abs	=	index
				else

					rix_drv	=	index
				end
			elsif rem

				rix_dir	=	index
			end
		end

		rix_drv	=	nil if (rix_drv || -1) <= (rix_abs || -1)
		rix_dir	=	nil if (rix_dir || -1) <= (rix_abs || -1)

		if rix_drv && rix_dir && rix_abs

			if rix_abs < rix_drv && rix_abs < rix_dir

				rix_abs	+=	1
				args	=	args[rix_abs..-1]
				rix_drv	-=	rix_abs
				rix_dir	-=	rix_abs
				rix_abs	=	nil
			end
		end

		if rix_drv.nil? && rix_dir.nil?

			if rix_abs

				args	=	args[rix_abs..-1]
			end

			dirs	=	args
			last	<<	args.pop unless args.empty?
		else

			if false

				;
			elsif rix_drv

				if rix_dir

					drv		=	args.delete_at rix_drv
					rix_dir	-=	1 if rix_drv < rix_dir
					dir		=	args.delete_at rix_dir

					args	=	args[rix_dir..-1]

					if dir.size > 1

						args.unshift dir[1..-1]
						dir	=	dir[0]
					end

					root	=	_Internal_Windows_Form.append_trailing_slash("#{drv}#{dir}")

					first	<<	root
					last	<<	args.pop unless args.empty?
					dirs	=	args
				elsif rix_abs

					drv		=	args.delete_at rix_drv
					rix_abs	-=	1 if rix_drv < rix_abs
					abs		=	args.delete_at rix_abs

					_, _, dir, bas, _, _, _, _	=	_Internal_Windows_Form.split_path abs

					args	=	args[rix_abs..-1]

					if dir.size > 1

						args.unshift dir[1..-1]
						dir	=	dir[0]
					end

					root	=	_Internal_Windows_Form.append_trailing_slash("#{drv}#{dir}#{bas}")

					first	<<	root
					last	<<	args.pop unless args.empty?
					dirs	=	args
				else

					first	<<	args.delete_at(rix_drv)
					last	<<	args.pop unless args.empty?
					dirs	=	args
				end
			elsif rix_dir

				if rix_abs

					abs		=	args.delete_at rix_abs
					rix_dir	-=	1 if rix_abs < rix_dir
					dir		=	args.delete_at rix_dir

					_, vol, _, _, _, _, _, _	=	_Internal_Windows_Form.split_path abs

					args	=	args[rix_dir..-1]

					root	=	_Internal_Windows_Form.append_trailing_slash("#{vol}#{dir}")

					first	<<	root
					last	<<	args.pop unless args.empty?
					dirs	=	args
				else

					args	=	args[rix_dir..-1]
					last	<<	args.pop unless args.empty?
					dirs	=	args
				end
			else

				;
			end
		end

		dirs	=	dirs.map { |el| _Internal_Windows_Form.append_trailing_slash el }

		(first + dirs + last).join('')
	end

	#
	# === Signature
	#
	# * *Options:*
	#  +:home+:: (String)
	#  +:locator+:: (boolean)
	#  +:make_canonical+:: (boolean)
	#  +:pwd+:: (String)
	def derive_relative_path origin, path, **options

		return path if origin.nil? || origin.empty?
		return path if path.nil? || path.empty?

		_Form_Windows			=	Form::Windows
		_Util_Windows			=	Util::Windows
		_Internal_Windows_Form	=	Internal_::Windows::Form

		_MPA_COMMON_OPTIONS	=	%i{ home locator pwd }

		tr_sl					=	_Internal_Windows_Form.get_trailing_slash(path)

		# Possibly naive home-correction

		return derive_relative_path(absolute_path(origin), path, **options) if _Form_Windows.path_is_homed?(origin)
		return derive_relative_path(origin, absolute_path(path), **options) if _Form_Windows.path_is_homed?(path)


		o_vol, o_rem, _ = _Internal_Windows_Form.get_windows_volume origin
		p_vol, p_rem, _ = _Internal_Windows_Form.get_windows_volume path

		if o_vol && p_vol

			# always give absolute answer when 'volume's are different

			if o_vol != p_vol

				if options[:make_path_canonical]

					path	=	_Util_Windows.make_path_canonical(path, make_slashes_canonical: true)
				else

					path	=	path.tr('/', '\\')
				end

				return path
			end
		end


		o_is_rooted	=	o_rem && _Internal_Windows_Form.char_is_path_name_separator?(o_rem[0])
		p_is_rooted	=	p_rem && _Internal_Windows_Form.char_is_path_name_separator?(p_rem[0])

		o_is_abs	=	o_vol && o_is_rooted
		p_is_abs	=	p_vol && p_is_rooted

		mpa_opts	=	options.select { |k| _MPA_COMMON_OPTIONS.include?(k) }

		if o_is_abs != p_is_abs || o_is_rooted != p_is_rooted

			origin	=	_Util_Windows.make_path_absolute(origin, **mpa_opts) unless o_is_abs
			path	=	_Util_Windows.make_path_absolute(path, **mpa_opts) unless p_is_abs

			return derive_relative_path(origin, path, **options)
		end

		origin	=	_Util_Windows.make_path_canonical(origin, make_slashes_canonical: true)
		path	=	_Util_Windows.make_path_canonical(path, make_slashes_canonical: true)

		return '.' + tr_sl.to_s if origin == path
		return path if '.\\' == origin

		if o_is_abs != p_is_abs || '.\\' == path

			origin	=	_Util_Windows.make_path_absolute(origin, make_canonical: true, **options.select { |k| _MPA_COMMON_OPTIONS.include?(k) })
			path	=	_Util_Windows.make_path_absolute(path, make_canonical: true, **options.select { |k| _MPA_COMMON_OPTIONS.include?(k) })
		end


		_, _, _, o3_basename, _, _, o6_parts, _	=	_Internal_Windows_Form.split_path(origin)
		_, _, _, p3_basename, _, _, p6_parts, _	=	_Internal_Windows_Form.split_path(path)

		o_parts	=	o6_parts
		o_parts	<<	o3_basename if o3_basename && '.' != o3_basename

		p_parts	=	p6_parts
		p_parts	<<	p3_basename if p3_basename && '.' != p3_basename


		while true

			break if o_parts.empty?
			break if p_parts.empty?

			o_part	=	o_parts[0]
			p_part	=	p_parts[0]

			if 1 == o_parts.size || 1 == p_parts.size

				o_part	=	_Internal_Windows_Form.append_trailing_slash o_part
				p_part	=	_Internal_Windows_Form.append_trailing_slash p_part
			end

			parts_equal = false

			if o_part.size == p_part.size

				o_part	=	o_part.tr('/', '\\') if o_part.include? '/'
				p_part	=	p_part.tr('/', '\\') if p_part.include? '/'

				parts_equal = o_part == p_part
			end


			if parts_equal

				o_parts.shift
				p_parts.shift
			else

				break
			end
		end


		return '.' + tr_sl.to_s if 0 == (o_parts.size + p_parts.size)

		return o_parts.map { |rp| '..' }.join('\\') + (tr_sl || (o_parts.size > 0 ? '\\' : nil)).to_s if p_parts.empty?


		ar		=	[ '..' ] * o_parts.size + p_parts
		last	=	ar.pop
		ar		=	ar.map { |el| _Internal_Windows_Form.append_trailing_slash(el) }

		last[-1] = '\\' if '/' == last[-1]

		ar.join + last.to_s
	end

	def make_path_absolute path, **options

		_Form_Windows			=	Form::Windows
		_Internal_Windows_Form	=	Internal_::Windows::Form

		Diagnostics.check_string_parameter(path, "path") if $DEBUG
		Diagnostics.check_options(options, known: %i{ home locator make_canonical pwd }) if $DEBUG

		return path if path.nil? || path.empty?

		r	=	nil

		if false

			;
		elsif _Form_Windows.path_is_homed? path

			home	=	nil
			home	||=	options[:home]
			home	||=	options[:locator].home if options.has_key?(:locator)
			home	||=	Dir.home

			unless _Internal_Windows_Form.has_trailing_slash? home

				home = home + path[1].to_s
			end

			r = combine_paths(home, path[2..-1])
		elsif _Form_Windows.path_is_UNC? path

			r	=	path
		elsif _Form_Windows.path_is_absolute? path

			r	=	path
		elsif _Form_Windows.path_is_rooted? path

			pwd	=	nil
			pwd	||=	options[:pwd]
			pwd	||=	options[:locator].pwd if options.has_key?(:locator)
			pwd	||=	Dir.pwd

			r = pwd[0..1] + path
		else

			pwd	=	nil
			pwd	||=	options[:pwd]
			pwd	||=	options[:locator].pwd if options.has_key?(:locator)
			pwd	||=	Dir.pwd

			r = combine_paths(pwd, path, elide_single_dots: false)
		end

		if options[:make_canonical]

			r	=	make_path_canonical r
		else

			vol, rem, _	=	_Internal_Windows_Form.get_windows_volume r

			_Internal_Windows_Form.elide_redundant_path_name_separators! rem

			r			=	"#{vol}#{rem}"
		end

		return r
	end

	# Converts a path into canonical form, which is to say that all possible
	# dots directory parts are removed:
	#
	# - single-dot parts - './' or '.\\' - are all removed
	# - double-dot parts - '../' or '..\\' - are removed where they follow a
	#    non-dots directory part, or where they follow the root
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +path+:: (String) The path to be evaluated. May not be +nil+
	#
	# * *Options:*
	#   - +:make_slashes_canonical+:: (boolean) Determines whether to
	#      additionally convert all forward slashes to backslashes
	def make_path_canonical path, **options

		Diagnostics.check_string_parameter(path, "path") if $DEBUG

		if path.include?('/') && options[:make_slashes_canonical]

			path = path.tr '/', '\\'
		end

		return path unless '.' == path[-1] || path =~ /[.\\\/][\\\/]/

		_Form	=	::LibPath::Internal_::Windows::Form
		_Array	=	::LibPath::Internal_::Array

		path	=	path[0...-1] if '.' == path[-1] && _Form.char_is_path_name_separator?(path[-2])


		f0_path, f1_volume, f2_directory, f3_basename, _, _, f6_dir_parts, _ = _Form.split_path path

		if f6_dir_parts.empty?

			case f3_basename
			when '.'

				return "#{f1_volume}.\\"
			when '..'

				return "#{f1_volume}..\\"
			else

				return f0_path
			end
		end

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

		is_rooted	=	_Form.char_is_path_name_separator?(f2_directory[0])

		new_parts	=	f6_dir_parts.dup
		new_parts.reject! { |p| '.\\' == p || './' == p }
		ix_2dots	=	_Array.index2(new_parts, '../', '..\\', 1)

		return f0_path unless new_parts.size != f6_dir_parts.size || ix_2dots

		while (ix_2dots || 0) > 0

			new_parts.delete_at(ix_2dots - 0)
			new_parts.delete_at(ix_2dots - 1) if ix_2dots != 1 || !is_rooted

			ix_2dots = _Array.index2(new_parts, '../', '..\\', 1)
		end

		if new_parts.empty? && (basename || '').empty?

			case f3_basename
			when nil, '.', '..'

				return '.' + (last_slash || '\\').to_s
			else

				return '.'
			end
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



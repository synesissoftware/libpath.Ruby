
require 'libpath/internal_/string'
require 'libpath/internal_/windows/drive'

module LibPath # :nodoc:
# @!visibility private
module Internal_ # :nodoc: all
# @!visibility private
module Windows # :nodoc:

# @!visibility private
module Form # :nodoc:

	# [INTERNAL] This function is undocumented, and subject to change at any
	# time
	#
	# @!visibility private
	def self.char_is_path_name_separator? c # :nodoc:

		'/' == c || '\\' == c
	end

	# [INTERNAL] This function is undocumented, and subject to change at any
	# time
	#
	# @!visibility private
	def self.append_trailing_slash s # :nodoc:

		return s if self.char_is_path_name_separator?(s[-1])

		s + '\\'
	end

	# [INTERNAL] This function is undocumented, and subject to change at any
	# time
	#
	# @!visibility private
	def self.get_trailing_slash s # :nodoc:

		last = s[-1]

		self.char_is_path_name_separator?(last) ? last : nil
	end

	# [INTERNAL] This function is undocumented, and subject to change at any
	# time
	#
	# @!visibility private
	def self.has_trailing_slash? s # :nodoc:

		self.char_is_path_name_separator?(s[-1])
	end

	# [INTERNAL] This function is undocumented, and subject to change at any
	# time
	#
	# @!visibility private
	def self.trim_trailing_slash s # :nodoc:

		return s unless self.char_is_path_name_separator?(s[-1])

		s.chop
	end

	# [INTERNAL] This function is undocumented, and subject to change at any
	# time
	#
	# @!visibility private
	def self.elide_redundant_path_name_separators s # :nodoc:

		s.gsub(/[\\\/]{2,}/, '\\')
	end

	# [INTERNAL] This function is undocumented, and subject to change at any
	# time
	#
	# @!visibility private
	def self.elide_redundant_path_name_separators! s # :nodoc:

		s.gsub!(/[\\\/]{2,}/, '\\')

		s
	end

	# [INTERNAL] This function is undocumented, and subject to change at any
	# time
	#
	# === Signature
	#
	# * *Parameters:*
	#  - +s+ (String)
	#
	# === Return
	# A 3-element array, consisting of [ volume, remainder, form ]
	#
	# @!visibility private
	def self.get_windows_volume s # :nodoc:

		# 0. not matched
		# 1. X:
		# 2. \\server\share
		# 3. \\?\X:
		# 4. \\?\server\share
		# 5. \\?\UNC\server\share
		# 6. \\.\device

		if '\\' == s[0]

			if '\\' == s[1]

				case s[2]
				when '?'

					if '\\' == s[3]

						if ':' == s[5] && ::LibPath::Internal_::Windows::Drive.character_is_drive_letter?(s[4])

							# 3. \\?\X:

							return [ s[0..5], s[6..-1], :form_3 ]
						end

						if 'U' == s[4] && 'N' == s[5] && 'C' == s[6]

							# 5. \\?\UNC\server\share

							if s =~ /^\\\\\?\\UNC\\[^\\]+\\[^\\\/]+/

								return [ $&, $', :form_5 ]
							end
						else

							if s =~ /^\\\\\?\\[^\\]+\\[^\\\/]+/

								# 4. \\?\server\share

								return [ $&, $', :form_4 ]
							end
						end

						return [ s, '', :malformed ]
					end
				when '.'

					if s =~ /^\\\\\.\\[^\\]+/

						# 6. \\.\device

						return [ $&, $', :form_6 ]
					end
				else

						if s =~ /^\\\\[^\\]+\\[^\\\/]+/

							# 2. \\server\share

							return [ $&, $', :form_2 ]
						end
				end
			else

			end
		elsif ':' == s[1] && ::LibPath::Internal_::Windows::Drive.character_is_drive_letter?(s[0])

			# 1. X:

			return [ s[0..1], s[2..-1], :form_1 ]
		end

		# 0. not matched

		[ nil, s, :form_0 ]
	end

	# [INTERNAL] This function is undocumented, and subject to change at any
	# time
	#
	# Returns tuple of:
	#
	# 0. source path (with redundant path name separators elided)
	# 1. Windows volume (which is always nil)
	# 2. Directory
	# 3. Basename
	# 4. Stem
	# 5. Extension
	# 6. Directory parts
	# 7. Directory path parts
	#
	# @!visibility private
	def self.split_path s # :nodoc:

		f1_volume		=	nil
		f2_directory	=	nil
		f3_basename		=	nil
		f4_stem			=	nil
		f5_extension	=	nil
		f6_dir_parts	=	[]
		f7_all_parts	=	[]

		f1_volume, rem, frm	=	self.get_windows_volume s

		self.elide_redundant_path_name_separators! rem

		f1_volume.define_singleton_method(:form) { frm } if f1_volume

		if :malformed == frm

			return [ s, f1_volume, nil, nil, nil, nil, [], [] ]
		end

		unless rem.empty?

			ri_slash		=	::LibPath::Internal_::String.rindex2(rem, '/', '\\')

			if ri_slash

				f2_directory	=	rem[0..ri_slash]
				f3_basename		=	rem[(1 + ri_slash)..-1]
			else

				f2_directory	=	nil
				f3_basename		=	rem
			end

			case f3_basename
			when '.', '..'

				f4_stem			=	f3_basename
				f5_extension	=	nil
			else

				ri_dot			=	f3_basename.rindex('.')

				if ri_dot

					f4_stem			=	f3_basename[0...ri_dot]
					f5_extension	=	f3_basename[ri_dot..-1]
				else

					f4_stem			=	f3_basename
					f5_extension	=	nil
				end
			end

			case f2_directory
			when nil

				;
			when '\\', '/'

				f6_dir_parts		=	[ f2_directory ]
			else

				parts				=	f2_directory.split(/([\\\/])/)

				f6_dir_parts		=	[]

				(0...(parts.size / 2)).each do |ix|

					f6_dir_parts	<<	parts[2 * ix + 0] + parts[2 * ix + 1]
				end
			end

			if f1_volume

				f7_all_parts		=	f6_dir_parts.dup

				f7_all_parts[0]		=	f1_volume + f7_all_parts[0].to_s
			else

				f7_all_parts		=	f6_dir_parts
			end
		end


		[ "#{f1_volume}#{rem}", f1_volume, f2_directory, f3_basename, f4_stem, f5_extension, f6_dir_parts, f7_all_parts ].map { |v| ::String === v && v.empty? ? nil : v }
	end
end # module Form

end # module Windows
end # module Internal_
end # module LibPath

# ############################## end of file ############################# #




module LibPath
module Internal_
module Unix

module Form

	def self.char_is_path_name_separator? c

		'/' == c
	end

	def self.append_trailing_slash s

		return s if '/' == s[-1]

		s + '/'
	end

	def self.get_trailing_slash s

		'/' == s[-1] ? '/' : nil
	end

	def self.has_trailing_slash? s

		'/' == s[-1]
	end

	def self.trim_trailing_slash s

		return s unless '/' == s[-1]

		s.chop
	end

	# Returns tuple of:
	#
	# 0. source path
	# 1. Windows volume (which is always nil)
	# 2. Directory
	# 3. Basename
	# 4. Stem
	# 5. Extension
	# 6. Directory parts
	# 7. Directory path parts
	def self.split_path s, **options

		f2_directory	=	nil
		f3_basename		=	nil
		f4_stem			=	nil
		f5_extension	=	nil
		f6_dir_parts	=	[]

		ri_slash		=	s.rindex('/')

		if ri_slash

			f2_directory	=	s[0..ri_slash]
			f3_basename		=	s[(1 + ri_slash)..-1]
		else

			f2_directory	=	nil
			f3_basename		=	s
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

		unless options[:suppress_parts]

			case f2_directory
			when nil

				;
			when '/'

				f6_dir_parts		=	[ '/' ]
			else

				f6_dir_parts		=	f2_directory.split('/').map { |v| v + '/' }
			end
		end


		[ s, nil, f2_directory, f3_basename, f4_stem, f5_extension, f6_dir_parts, f6_dir_parts ].map { |v| ::String === v && v.empty? ? nil : v }
	end
end # module Form

end # module Unix
end # module Internal_
end # module LibPath


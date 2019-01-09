
require 'libpath/internal_/string'
#require 'libpath/internal_/windows'

module LibPath
module Internal_
module Windows

module Form

	def self.char_is_path_name_separator c

		'/' == c || '\\' == c
	end

	def self.append_trailing_slash s

		return s if self.char_is_path_name_separator(s[-1])

		s + '\\'
	end

	def self.get_trailing_slash s

		last = s[-1]

		self.char_is_path_name_separator(last) ? last : nil
	end

	def self.has_trailing_slash? s

		self.char_is_path_name_separator(s[-1])
	end

	def self.trim_trailing_slash s

		return s unless self.char_is_path_name_separator(s[-1])

		s.chop
	end
end # module Form

end # module Windows
end # module Internal_
end # module LibPath


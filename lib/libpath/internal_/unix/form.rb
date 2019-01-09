
module LibPath
module Internal_
module Unix

module Form

	def self.char_is_path_name_separator c

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
end # module Form

end # module Unix
end # module Internal_
end # module LibPath


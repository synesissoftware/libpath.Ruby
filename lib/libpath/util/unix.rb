
require 'libpath/diagnostics'
require 'libpath/internal_/unix/form'

module LibPath
module Util
module Unix

module LibPath_Util_Unix_Methods

	#
	# === Signature
	#
	# * *Parameters:*
	#   - +path+:: (String) The path to be evaluated. May not be +nil+
	def make_path_canonical path

		Diagnostics.check_string_parameter(path, "path") if $DEBUG

		return path unless '.' == path[-1] || path.include?('./')

		f	=	::LibPath::Internal_::Unix::Form

		_, _, _, f3_basename, _, _, f6_dir_parts, _ = f.split_path path

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



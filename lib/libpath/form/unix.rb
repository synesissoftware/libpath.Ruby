
require 'libpath/diagnostics'

module LibPath
module Form
module Unix

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



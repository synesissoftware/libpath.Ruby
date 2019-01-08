
require 'libpath/diagnostics'
require 'libpath/internal_/windows/drive'

module LibPath
module Form
module Windows

module LibPath_Form_Windows_Methods

	# Evaluates whether the given path is absolute, which means it is either
	# rooted (begins with '/') or is homed (is '~' or begins with '~/')
	#
	# === Signature
	#
	# * *Parameters:*
	#   - +path+:: (String) The path to be evaluated. May not be +nil+
	def path_is_absolute? path

		Diagnostics.check_string_parameter(path, "path") if $DEBUG

		if path.size > 2

			if ':' == path[1]

				if Internal_::Windows::Drive.character_is_drive_letter? path[0]

					return '/' == path[2] || '\\' == path[2]
				end
			end
		end

		return true if path_is_homed? path

		return true if path_is_UNC? path

		false
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

			return '/' == path[1] || '\\' == path[1]
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

				path_is_UNC? path
			else

				true
			end
		else

			if path.size > 2

				if ':' == path[1]

					if Internal_::Windows::Drive.character_is_drive_letter? path[0]

						return '/' == path[2] || '\\' == path[2]
					end
				end
			end

			false
		end
	end

	def path_is_UNC? path

		Diagnostics.check_string_parameter(path, "path") if $DEBUG

		/^\\\\[^\\]+\\[^\\]+\\/ =~ path ? true : false
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



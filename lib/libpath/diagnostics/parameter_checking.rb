
module LibPath
module Diagnostics

	def self.check_string_parameter param_value, param_name, **options

		case param_value
		when nil

			unless options[:allow_nil]

				raise ::ArgumentError, "parameter '#{param_name}' may not be nil"
			end

			;
		when ::String

			;
		else

			unless param_value.respond_to?(:to_str)

				raise ::TypeError, "parameter '#{param_name}' must be instance of #{::String} or respond to #to_str()"
			end
		end
	end

	def self.check_options h, *args, **options

		if known = options[:known] then

			h.each_key do |k|

				raise ::ArgumentError, "unknown key '#{k}'" unless known.include?(k)
			end
		end

	end
end # module Diagnostics
end # module LibPath

# ############################## end of file ############################# #



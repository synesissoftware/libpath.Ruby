
# :stopdoc:


module LibPath
# @!visibility private
module Internal_ # :nodoc: all

  # @!visibility private
  module String # :nodoc:

    # @!visibility private
    def self.rindex2(s, c1, c2) # :nodoc:

      ri_1 = s.rindex(c1)
      ri_2 = s.rindex(c2)

      if ri_1

        if ri_2

          ri_1 < ri_2 ? ri_2 : ri_1
        else

          ri_1
        end
      else

        ri_2
      end
    end
  end # module String
end # module Internal_
end # module LibPath


# :startdoc:


# ############################## end of file ############################# #


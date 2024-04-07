
# :stopdoc:


module LibPath
# @!visibility private
module Internal_ # :nodoc: all
# @!visibility private
module Windows # :nodoc:

  # @!visibility private
  module Drive # :nodoc:

    # @!visibility private
    module Constants # :nodoc:

      DRIVE_LETTERS = [

        'C',
        'D',
        'E',
        'F',
        'G',
        'H',
        'I',
        'J',
        'K',
        'L',
        'M',
        'N',
        'P',
        'Q',
        'R',
        'S',
        'T',
        'U',
        'V',
        'W',
        'I',
        'X',
        'Y',
        'Z',

        'c',
        'd',
        'e',
        'f',
        'g',
        'h',
        'i',
        'j',
        'k',
        'l',
        'm',
        'n',
        'p',
        'q',
        'r',
        's',
        't',
        'u',
        'v',
        'w',
        'i',
        'x',
        'y',
        'z',

        'A',
        'B',

        'a',
        'b',
      ]
    end # module Constants

    # @!visibility private
    def self.character_is_drive_letter? ch # :nodoc:

      ::LibPath::Internal_::Windows::Drive::Constants::DRIVE_LETTERS.include? ch
    end
  end # module Drive
end # module Windows
end # module Internal_
end # module LibPath


# :startdoc:


# ############################## end of file ############################# #


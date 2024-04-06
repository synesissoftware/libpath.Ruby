#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 3), 'lib')

require 'libpath/exceptions/libpath_base_exception'

require 'xqsr3/extensions/test/unit'
#require 'test/unit'

class Test_LibPathBaseException < Test::Unit::TestCase

  include ::LibPath::Exceptions

  def test_exception_exists_and_is_a_class

    assert defined?(LibPathBaseException)

    assert LibPathBaseException.is_a?(::Class)
  end

  def test_cannot_be_initialised

    assert_raise_with_message(::NoMethodError, /private.*method.*new.*LibPathBaseException/) { LibPathBaseException.new(nil) }
  end
end


# ############################## end of file ############################# #


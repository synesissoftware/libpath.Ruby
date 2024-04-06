#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 3), 'lib')

require 'libpath/exceptions/malformed_name_exception'

require 'test/unit'

class Test_MalformedNameException < Test::Unit::TestCase

  include ::LibPath::Exceptions

  def test_class_exists

    assert defined?(MalformedNameException)

    assert MalformedNameException.is_a?(::Class)
  end

  def test_can_be_initialised

    mnx = MalformedNameException.new("abc\0def")

    assert_not_nil mnx
    assert_not_nil mnx.name
    assert_match /abc.*def/, mnx.name
    assert_match /malformed name 'abc.*def'/, mnx.message
  end
end


# ############################## end of file ############################# #


#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 3), 'lib')


require 'libpath/util'

require 'test/unit'

require 'libpath/internal_/platform'


class Test_LibPath_Util_combine_paths < Test::Unit::TestCase

  F = ::LibPath::Util

  def test_no_arguments

    assert_equal '', F.combine_paths()
  end

  def test_single_argument

    assert_equal ' ', F.combine_paths(' ')
    assert_equal 'a', F.combine_paths('a')
    assert_equal 'abcdef/ghi/jkl.mno', F.combine_paths('abcdef/ghi/jkl.mno')
    assert_equal '/', F.combine_paths('/')
  end

  def test_relative_cases

    if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

      assert_equal 'a\\b\\c/d', F.combine_paths('a', 'b', 'c/d')

      assert_equal 'a\\b', F.combine_paths('', 'a', '', '', 'b')

      assert_equal 'a\\ \\b', F.combine_paths('', 'a', '', ' ', 'b')
    else

      assert_equal 'a/b/c/d', F.combine_paths('a', 'b', 'c/d')

      assert_equal 'a/b', F.combine_paths('', 'a', '', '', 'b')

      assert_equal 'a/ /b', F.combine_paths('', 'a', '', ' ', 'b')
    end
  end

  def test_tail_absolute_cases

    assert_equal '/', F.combine_paths('a', '/')

    assert_equal '/', F.combine_paths('a/b/c/d', '/')

    assert_equal '/', F.combine_paths('a', 'b', '/')

    if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

      assert_equal 'X:/', F.combine_paths('a', 'X:/')
      assert_equal 'X:\\', F.combine_paths('a', 'X:\\')
      assert_equal '\\\\?\\X:\\', F.combine_paths('a', '\\\\?\\X:\\')
    end
  end

  if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

    def test_tail_absolute_cases_2

      assert_equal 'Y:/', F.combine_paths('a', 'X:/', 'Y:/')
      assert_equal 'Y:\\', F.combine_paths('a', 'X:/', 'Y:\\')
      assert_equal 'Y:\\', F.combine_paths('a', '\\\\?\\X:/', 'Y:\\')
      assert_equal '\\\\?\\Y:\\', F.combine_paths('a', 'X:/', '\\\\?\\Y:\\')
    end

    def test_tail_absolute_cases_3

      assert_equal 'X:\\', F.combine_paths('a', 'X:', '\\')
      assert_equal 'X:\\', F.combine_paths('a', '\\', 'X:')
      assert_equal 'X:\\', F.combine_paths('X:', 'a', '\\')

      assert_equal '\\\\?\\X:\\', F.combine_paths('a', '\\\\?\\X:', '\\')
      assert_equal '\\\\?\\X:\\', F.combine_paths('a', '\\', '\\\\?\\X:')
      assert_equal '\\\\?\\X:\\', F.combine_paths('\\\\?\\X:', 'a', '\\')
    end

    def test_tail_absolute_cases_4

      assert_equal 'Z:\\', F.combine_paths('a', 'X:/', '\\', 'Z:')

      assert_equal '\\\\?\\Z:\\', F.combine_paths('a', '\\\\?\\X:/', '\\', '\\\\?\\Z:')

      assert_equal '\\\\?\\UNC\\server\\share/abc', F.combine_paths('a', '\\\\?\\X:/', '/abc', '\\\\?\\UNC\\server\\share')
    end

    def test_tail_absolute_cases_5

      assert_equal 'Z:\\dir\\a\\b', F.combine_paths('a', 'X:/y', '\\dir', 'Z:', 'a', 'b')

      assert_equal 'Z:\\dir\\a\\b', F.combine_paths('a', '\\\\?\\X:/y', '\\dir', 'Z:', 'a', 'b')

      assert_equal '\\\\?\\Z:\\dir\\a\\b', F.combine_paths('a', 'X:/y', '\\dir', '\\\\?\\Z:', 'a', 'b')
    end

    def test_tail_absolute_cases_6

      assert_equal 'Z:\\b', F.combine_paths('a', 'X:/', 'Z:', 'a', '\\', 'b')
    end

    def test_tail_absolute_cases_7

      assert_equal 'Z:\\a\\c\\b', F.combine_paths('a', 'X:/', '\\a', 'c', 'Z:', 'b')
    end

    def test_tail_absolute_cases_8

      assert_equal 'X:/y\\b', F.combine_paths('a', '\\a', 'c', 'Z:', 'X:/y', 'b')
    end

    def test_tail_absolute_cases_9

      assert_equal 'Z:\\y\\b', F.combine_paths('a', '\\a', 'c', 'X:\\y', 'Z:', 'b')
      assert_equal 'Z:/y\\b', F.combine_paths('a', '\\a', 'c', 'X:/y', 'Z:', 'b')
    end
  end

  def test_tail_absolute_cases_10

    if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

      assert_equal 'X:\\dir-1\\dir-2\\b', F.combine_paths('a', '\\a', 'c', 'X:/y', '\\dir-1\\dir-2', 'b')
      assert_equal 'X:\\dir-1/dir-2\\b', F.combine_paths('a', '\\a', 'c', 'X:/y', '\\dir-1/dir-2', 'b')
    end

    assert_equal '/', F.combine_paths('a', '/')

    assert_equal '/', F.combine_paths('a/b/c/d', '/')

    assert_equal '/', F.combine_paths('a', 'b', '/')
  end

  if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

    def test_drive_only

      assert_equal 'D:', F.combine_paths('D:')
      assert_equal 'D:dir-1\\dir-2', F.combine_paths('D:', 'dir-1\\dir-2')

      assert_equal '\\\\?\\D:', F.combine_paths('\\\\?\\D:')
      assert_equal '\\\\?\\D:dir-1\\dir-2', F.combine_paths('\\\\?\\D:', 'dir-1\\dir-2')
    end
  end

  def test_embedded_absolute_cases

    if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

      assert_equal '/a\\b\\c/d', F.combine_paths('x/y/z', 'z', '/a', 'b', 'c/d')
      assert_equal '\\a\\b\\c/d', F.combine_paths('x/y/z', 'z', '\\a', 'b', 'c/d')
    else

      assert_equal '/a/b/c/d', F.combine_paths('x/y/z', 'z', '/a', 'b', 'c/d')
      assert_equal '/a/b/c/d', F.combine_paths('x/y/z', 'z', '/a', 'b', 'c/d')
    end
  end

  def test_multiple_embedded_absolute_cases

    if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

      assert_equal '/a\\b\\c/d', F.combine_paths('x/y/z', '/z', '/a', 'b', 'c/d')

      assert_equal '/a\\b\\c/d', F.combine_paths('x/y/z', '/z', '/a', 'b', 'c/d')
    else

      assert_equal '/a/b/c/d', F.combine_paths('x/y/z', '/z', '/a', 'b', 'c/d')

      assert_equal '/a/b/c/d', F.combine_paths('x/y/z', '/z', '/a', 'b', 'c/d')
    end
  end
end


# ############################## end of file ############################# #


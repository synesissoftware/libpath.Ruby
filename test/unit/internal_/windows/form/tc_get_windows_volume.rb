#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 5), 'lib')


require 'libpath/internal_/windows/form'

require 'test/unit'


class Test_Internal_Windows_Form_get_windows_volume < Test::Unit::TestCase

  F = ::LibPath::Internal_::Windows::Form

  def test_empty_string

    r = F.get_windows_volume('')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_nil r[0]
    assert_equal '', r[1]
    assert_equal :form_0, r[2]
  end

  def test_no_seps

    r = F.get_windows_volume('abc')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_nil r[0]
    assert_equal 'abc', r[1]
    assert_equal :form_0, r[2]
  end

  def test_homed

    r = F.get_windows_volume('~')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_nil r[0]
    assert_equal '~', r[1]
    assert_equal :form_0, r[2]
  end

  def test_rooted

    r = F.get_windows_volume('\\abc')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_nil r[0]
    assert_equal '\\abc', r[1]
    assert_equal :form_0, r[2]
  end

  def test_drive_standard

    r = F.get_windows_volume('h:')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal 'h:', r[0]
    assert_equal '', r[1]
    assert_equal :form_1, r[2]

    r = F.get_windows_volume('X:\\')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal 'X:', r[0]
    assert_equal '\\', r[1]
    assert_equal :form_1, r[2]

    r = F.get_windows_volume('X:\\abc')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal 'X:', r[0]
    assert_equal '\\abc', r[1]
    assert_equal :form_1, r[2]

    r = F.get_windows_volume('X:/abc')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal 'X:', r[0]
    assert_equal '/abc', r[1]
    assert_equal :form_1, r[2]
  end

  def test_device

    r = F.get_windows_volume('\\\\.\\the-device-name\\file')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal '\\\\.\\the-device-name', r[0]
    assert_equal '\\file', r[1]
    assert_equal :form_6, r[2]

    r = F.get_windows_volume('\\\\.\\the-device-name')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal '\\\\.\\the-device-name', r[0]
    assert_equal '', r[1]
    assert_equal :form_6, r[2]
  end

  def test_drive_long

    r = F.get_windows_volume('\\\\?\\h:')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal '\\\\?\\h:', r[0]
    assert_equal '', r[1]
    assert_equal :form_3, r[2]

    r = F.get_windows_volume('\\\\?\\X:\\')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal '\\\\?\\X:', r[0]
    assert_equal '\\', r[1]
    assert_equal :form_3, r[2]

    r = F.get_windows_volume('\\\\?\\X:\\abc')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal '\\\\?\\X:', r[0]
    assert_equal '\\abc', r[1]
    assert_equal :form_3, r[2]

    r = F.get_windows_volume('\\\\?\\X:/abc')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal '\\\\?\\X:', r[0]
    assert_equal '/abc', r[1]
    assert_equal :form_3, r[2]
  end

  def test_UNC_standard

    r = F.get_windows_volume('\\\\the-server-name\\the-share-name')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal '\\\\the-server-name\\the-share-name', r[0]
    assert_equal '', r[1]
    assert_equal :form_2, r[2]

    r = F.get_windows_volume('\\\\the-server-name\\the-share-name\\')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal '\\\\the-server-name\\the-share-name', r[0]
    assert_equal '\\', r[1]
    assert_equal :form_2, r[2]

    r = F.get_windows_volume('\\\\the-server-name\\the-share-name\\file.ext')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal '\\\\the-server-name\\the-share-name', r[0]
    assert_equal '\\file.ext', r[1]
    assert_equal :form_2, r[2]
  end

  def test_UNC_long

    r = F.get_windows_volume('\\\\?\\the-server-name\\the-share-name')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal '\\\\?\\the-server-name\\the-share-name', r[0]
    assert_equal '', r[1]
    assert_equal :form_4, r[2]

    r = F.get_windows_volume('\\\\?\\the-server-name\\the-share-name\\')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal '\\\\?\\the-server-name\\the-share-name', r[0]
    assert_equal '\\', r[1]
    assert_equal :form_4, r[2]

    r = F.get_windows_volume('\\\\?\\the-server-name\\the-share-name\\file.ext')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal '\\\\?\\the-server-name\\the-share-name', r[0]
    assert_equal '\\file.ext', r[1]
    assert_equal :form_4, r[2]
  end

  def test_UNC_full

    r = F.get_windows_volume('\\\\?\\UNC\\the-server-name\\the-share-name')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal '\\\\?\\UNC\\the-server-name\\the-share-name', r[0]
    assert_equal '', r[1]
    assert_equal :form_5, r[2]

    r = F.get_windows_volume('\\\\?\\UNC\\the-server-name\\the-share-name\\')

    assert_kind_of ::Array, r
    assert_equal 3, r.size
    assert_equal '\\\\?\\UNC\\the-server-name\\the-share-name', r[0]
    assert_equal '\\', r[1]
    assert_equal :form_5, r[2]
  end
end


# ############################## end of file ############################# #


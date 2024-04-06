#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 4), 'lib')


require 'libpath/internal_/windows/form'

require 'test/unit'


class Test_LibPath_Internal_Windows_Form_split_path < Test::Unit::TestCase

  F = ::LibPath::Internal_::Windows::Form

  def test_empty

    r = F.split_path ''

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_nil r[0]
    assert_nil r[1]
    assert_nil r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_empty r[6]
    assert_kind_of ::Array, r[7]
    assert_empty r[7]
  end

  def test_dot

    r = F.split_path '.'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '.', r[0]
    assert_nil r[1]
    assert_nil r[2]
    assert_equal '.', r[3]
    assert_equal '.', r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_empty r[6]
    assert_kind_of ::Array, r[7]
    assert_empty r[7]
  end

  def test_dots

    r = F.split_path '..'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '..', r[0]
    assert_nil r[1]
    assert_nil r[2]
    assert_equal '..', r[3]
    assert_equal '..', r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_empty r[6]
    assert_kind_of ::Array, r[7]
    assert_empty r[7]
  end

  def test_stems

    r = F.split_path 'a'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'a', r[0]
    assert_nil r[1]
    assert_nil r[2]
    assert_equal 'a', r[3]
    assert_equal 'a', r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_empty r[6]
    assert_kind_of ::Array, r[7]
    assert_empty r[7]

    r = F.split_path 'abc'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'abc', r[0]
    assert_nil r[1]
    assert_nil r[2]
    assert_equal 'abc', r[3]
    assert_equal 'abc', r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_empty r[6]
    assert_kind_of ::Array, r[7]
    assert_empty r[7]

    r = F.split_path 'abcdefghi'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'abcdefghi', r[0]
    assert_nil r[1]
    assert_nil r[2]
    assert_equal 'abcdefghi', r[3]
    assert_equal 'abcdefghi', r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_empty r[6]
    assert_kind_of ::Array, r[7]
    assert_empty r[7]
  end

  def test_basenames

    r = F.split_path 'a.x'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'a.x', r[0]
    assert_nil r[1]
    assert_nil r[2]
    assert_equal 'a.x', r[3]
    assert_equal 'a', r[4]
    assert_equal '.x', r[5]
    assert_kind_of ::Array, r[6]
    assert_empty r[6]
    assert_kind_of ::Array, r[7]
    assert_empty r[7]

    r = F.split_path 'abc.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'abc.ext', r[0]
    assert_nil r[1]
    assert_nil r[2]
    assert_equal 'abc.ext', r[3]
    assert_equal 'abc', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_empty r[6]
    assert_kind_of ::Array, r[7]
    assert_empty r[7]

    r = F.split_path 'abcd.efghi.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_nil r[1]
    assert_nil r[2]
    assert_equal 'abcd.efghi.ext', r[3]
    assert_equal 'abcd.efghi', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_empty r[6]
    assert_kind_of ::Array, r[7]
    assert_empty r[7]
  end

  def test_directories

    r = F.split_path 'a/'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'a/', r[0]
    assert_nil r[1]
    assert_equal 'a/', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ 'a/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ 'a/' ], r[7]

    r = F.split_path 'a\\'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'a\\', r[0]
    assert_nil r[1]
    assert_equal 'a\\', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ 'a\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ 'a\\' ], r[7]

    r = F.split_path 'abc/'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'abc/', r[0]
    assert_nil r[1]
    assert_equal 'abc/', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ 'abc/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ 'abc/' ], r[7]

    r = F.split_path 'abc\\'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'abc\\', r[0]
    assert_nil r[1]
    assert_equal 'abc\\', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ 'abc\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ 'abc\\' ], r[7]

    r = F.split_path 'abc/def/'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'abc/def/', r[0]
    assert_nil r[1]
    assert_equal 'abc/def/', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ 'abc/', 'def/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ 'abc/', 'def/' ], r[7]

    r = F.split_path 'abc\\def\\'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'abc\\def\\', r[0]
    assert_nil r[1]
    assert_equal 'abc\\def\\', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ 'abc\\', 'def\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ 'abc\\', 'def\\' ], r[7]

    r = F.split_path '/'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '/', r[0]
    assert_nil r[1]
    assert_equal '/', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '/' ], r[7]

    r = F.split_path '\\'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\', r[0]
    assert_nil r[1]
    assert_equal '\\', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\' ], r[7]

    r = F.split_path '/abc/'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '/abc/', r[0]
    assert_nil r[1]
    assert_equal '/abc/', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '/', 'abc/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '/', 'abc/' ], r[7]

    r = F.split_path '\\abc\\'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\abc\\', r[0]
    assert_nil r[1]
    assert_equal '\\abc\\', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\', 'abc\\' ], r[7]

    r = F.split_path '/abc/def/'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '/abc/def/', r[0]
    assert_nil r[1]
    assert_equal '/abc/def/', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '/', 'abc/', 'def/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '/', 'abc/', 'def/' ], r[7]

    r = F.split_path '\\abc\\def\\'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\abc\\def\\', r[0]
    assert_nil r[1]
    assert_equal '\\abc\\def\\', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc\\', 'def\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\', 'abc\\', 'def\\' ], r[7]

    r = F.split_path '~/abc/def/'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '~/abc/def/', r[0]
    assert_nil r[1]
    assert_equal '~/abc/def/', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '~/', 'abc/', 'def/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '~/', 'abc/', 'def/' ], r[7]

    r = F.split_path '~\\abc\\def\\'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '~\\abc\\def\\', r[0]
    assert_nil r[1]
    assert_equal '~\\abc\\def\\', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '~\\', 'abc\\', 'def\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '~\\', 'abc\\', 'def\\' ], r[7]

    r = F.split_path '~/abc\\def/'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '~/abc\\def/', r[0]
    assert_nil r[1]
    assert_equal '~/abc\\def/', r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '~/', 'abc\\', 'def/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '~/', 'abc\\', 'def/' ], r[7]
  end

  def test_paths

    r = F.split_path 'a/b'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'a/b', r[0]
    assert_nil r[1]
    assert_equal 'a/', r[2]
    assert_equal 'b', r[3]
    assert_equal 'b', r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ 'a/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ 'a/' ], r[7]

    r = F.split_path 'a\\b'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'a\\b', r[0]
    assert_nil r[1]
    assert_equal 'a\\', r[2]
    assert_equal 'b', r[3]
    assert_equal 'b', r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ 'a\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ 'a\\' ], r[7]

    r = F.split_path 'abc/file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'abc/file.ext', r[0]
    assert_nil r[1]
    assert_equal 'abc/', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ 'abc/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ 'abc/' ], r[7]

    r = F.split_path 'abc\\file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'abc\\file.ext', r[0]
    assert_nil r[1]
    assert_equal 'abc\\', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ 'abc\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ 'abc\\' ], r[7]

    r = F.split_path '/abc/file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '/abc/file.ext', r[0]
    assert_nil r[1]
    assert_equal '/abc/', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '/', 'abc/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '/', 'abc/' ], r[7]

    r = F.split_path '\\abc\\file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\abc\\file.ext', r[0]
    assert_nil r[1]
    assert_equal '\\abc\\', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\', 'abc\\' ], r[7]

    r = F.split_path '/abc/.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '/abc/.ext', r[0]
    assert_nil r[1]
    assert_equal '/abc/', r[2]
    assert_equal '.ext', r[3]
    assert_nil r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '/', 'abc/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '/', 'abc/' ], r[7]

    r = F.split_path '\\abc\\.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\abc\\.ext', r[0]
    assert_nil r[1]
    assert_equal '\\abc\\', r[2]
    assert_equal '.ext', r[3]
    assert_nil r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\', 'abc\\' ], r[7]

    r = F.split_path '/abc/ext.'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '/abc/ext.', r[0]
    assert_nil r[1]
    assert_equal '/abc/', r[2]
    assert_equal 'ext.', r[3]
    assert_equal 'ext', r[4]
    assert_equal '.', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '/', 'abc/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '/', 'abc/' ], r[7]

    r = F.split_path '\\abc\\ext.'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\abc\\ext.', r[0]
    assert_nil r[1]
    assert_equal '\\abc\\', r[2]
    assert_equal 'ext.', r[3]
    assert_equal 'ext', r[4]
    assert_equal '.', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\', 'abc\\' ], r[7]
  end

  def test_paths_with_dots_basenames

    r = F.split_path '/.'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '/.', r[0]
    assert_nil r[1]
    assert_equal '/', r[2]
    assert_equal '.', r[3]
    assert_equal '.', r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '/' ], r[7]

    r = F.split_path '\\.'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\.', r[0]
    assert_nil r[1]
    assert_equal '\\', r[2]
    assert_equal '.', r[3]
    assert_equal '.', r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\' ], r[7]

    r = F.split_path '/..'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '/..', r[0]
    assert_nil r[1]
    assert_equal '/', r[2]
    assert_equal '..', r[3]
    assert_equal '..', r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '/' ], r[7]

    r = F.split_path '\\..'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\..', r[0]
    assert_nil r[1]
    assert_equal '\\', r[2]
    assert_equal '..', r[3]
    assert_equal '..', r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\' ], r[7]

    r = F.split_path './..'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal './..', r[0]
    assert_nil r[1]
    assert_equal './', r[2]
    assert_equal '..', r[3]
    assert_equal '..', r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ './' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ './' ], r[7]

    r = F.split_path '.\\..'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '.\\..', r[0]
    assert_nil r[1]
    assert_equal '.\\', r[2]
    assert_equal '..', r[3]
    assert_equal '..', r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '.\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '.\\' ], r[7]
  end

  def test_paths_with_drives_form1

    r = F.split_path 'C:/abc/file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'C:/abc/file.ext', r[0]
    assert_equal 'C:', r[1]
    assert_equal :form_1, r[1].form
    assert_equal '/abc/', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '/', 'abc/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ 'C:/', 'abc/' ], r[7]

    r = F.split_path 'C:\\abc\\file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal 'C:\\abc\\file.ext', r[0]
    assert_equal 'C:', r[1]
    assert_equal :form_1, r[1].form
    assert_equal '\\abc\\', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ 'C:\\', 'abc\\' ], r[7]
  end

  def test_paths_with_drives_form3

    r = F.split_path '\\\\?\\d:/abc/file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\\\?\\d:/abc/file.ext', r[0]
    assert_equal '\\\\?\\d:', r[1]
    assert_equal :form_3, r[1].form
    assert_equal '/abc/', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '/', 'abc/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\\\?\\d:/', 'abc/' ], r[7]

    r = F.split_path '\\\\?\\d:\\abc\\file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\\\?\\d:\\abc\\file.ext', r[0]
    assert_equal '\\\\?\\d:', r[1]
    assert_equal :form_3, r[1].form
    assert_equal '\\abc\\', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\\\?\\d:\\', 'abc\\' ], r[7]
  end

  def test_paths_with_UNC_form2

    r = F.split_path '\\\\101.202.303.404:1234\\some-share-or-other\\abc\\file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\\\101.202.303.404:1234\\some-share-or-other\\abc\\file.ext', r[0]
    assert_equal '\\\\101.202.303.404:1234\\some-share-or-other', r[1]
    assert_equal :form_2, r[1].form
    assert_equal '\\abc\\', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\\\101.202.303.404:1234\\some-share-or-other\\', 'abc\\' ], r[7]

    r = F.split_path '\\\\101.202.303.404:1234\\some-share-or-other\\abc/file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\\\101.202.303.404:1234\\some-share-or-other\\abc/file.ext', r[0]
    assert_equal '\\\\101.202.303.404:1234\\some-share-or-other', r[1]
    assert_equal :form_2, r[1].form
    assert_equal '\\abc/', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\\\101.202.303.404:1234\\some-share-or-other\\', 'abc/' ], r[7]
  end

  def test_paths_with_UNC_form4

    r = F.split_path '\\\\?\\101.202.303.404:1234\\some-share-or-other\\abc\\file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\\\?\\101.202.303.404:1234\\some-share-or-other\\abc\\file.ext', r[0]
    assert_equal '\\\\?\\101.202.303.404:1234\\some-share-or-other', r[1]
    assert_equal :form_4, r[1].form
    assert_equal '\\abc\\', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\\\?\\101.202.303.404:1234\\some-share-or-other\\', 'abc\\' ], r[7]

    r = F.split_path '\\\\?\\101.202.303.404:1234\\some-share-or-other\\abc/file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\\\?\\101.202.303.404:1234\\some-share-or-other\\abc/file.ext', r[0]
    assert_equal '\\\\?\\101.202.303.404:1234\\some-share-or-other', r[1]
    assert_equal :form_4, r[1].form
    assert_equal '\\abc/', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\\\?\\101.202.303.404:1234\\some-share-or-other\\', 'abc/' ], r[7]
  end

  def test_paths_with_UNC_form5

    r = F.split_path '\\\\?\\UNC\\101.202.303.404:1234\\some-share-or-other\\abc\\file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\\\?\\UNC\\101.202.303.404:1234\\some-share-or-other\\abc\\file.ext', r[0]
    assert_equal '\\\\?\\UNC\\101.202.303.404:1234\\some-share-or-other', r[1]
    assert_equal :form_5, r[1].form
    assert_equal '\\abc\\', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\\\?\\UNC\\101.202.303.404:1234\\some-share-or-other\\', 'abc\\' ], r[7]

    r = F.split_path '\\\\?\\UNC\\101.202.303.404:1234\\some-share-or-other\\abc/file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\\\?\\UNC\\101.202.303.404:1234\\some-share-or-other\\abc/file.ext', r[0]
    assert_equal '\\\\?\\UNC\\101.202.303.404:1234\\some-share-or-other', r[1]
    assert_equal :form_5, r[1].form
    assert_equal '\\abc/', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\\\?\\UNC\\101.202.303.404:1234\\some-share-or-other\\', 'abc/' ], r[7]
  end

  def test_paths_with_device_form6

    r = F.split_path '\\\\.\\{some-device-name#abcd}\\abc\\file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\\\.\\{some-device-name#abcd}\\abc\\file.ext', r[0]
    assert_equal '\\\\.\\{some-device-name#abcd}', r[1]
    assert_equal :form_6, r[1].form
    assert_equal '\\abc\\', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc\\' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\\\.\\{some-device-name#abcd}\\', 'abc\\' ], r[7]

    r = F.split_path '\\\\.\\{some-device-name#abcd}\\abc/file.ext'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\\\.\\{some-device-name#abcd}\\abc/file.ext', r[0]
    assert_equal '\\\\.\\{some-device-name#abcd}', r[1]
    assert_equal :form_6, r[1].form
    assert_equal '\\abc/', r[2]
    assert_equal 'file.ext', r[3]
    assert_equal 'file', r[4]
    assert_equal '.ext', r[5]
    assert_kind_of ::Array, r[6]
    assert_equal [ '\\', 'abc/' ], r[6]
    assert_kind_of ::Array, r[7]
    assert_equal [ '\\\\.\\{some-device-name#abcd}\\', 'abc/' ], r[7]
  end

  def test_paths_with_invalid_UNC

    r = F.split_path '\\\\?\\server'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\\\?\\server', r[0]
    assert_equal '\\\\?\\server', r[1]
    assert_equal :malformed, r[1].form
    assert_nil r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_empty r[6]
    assert_kind_of ::Array, r[7]
    assert_empty r[7]

    r = F.split_path '\\\\?\\server\\'

    assert_kind_of ::Array, r
    assert_equal 8, r.size
    assert_equal '\\\\?\\server\\', r[0]
    assert_equal '\\\\?\\server\\', r[1]
    assert_equal :malformed, r[1].form
    assert_nil r[2]
    assert_nil r[3]
    assert_nil r[4]
    assert_nil r[5]
    assert_kind_of ::Array, r[6]
    assert_empty r[6]
    assert_kind_of ::Array, r[7]
    assert_empty r[7]
  end
end


# ############################## end of file ############################# #


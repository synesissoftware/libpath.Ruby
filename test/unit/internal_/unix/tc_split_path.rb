#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 4), 'lib')

require 'libpath/internal_/unix/form'

require 'test/unit'

class Test_LibPath_Internal_Unix_Form_split_path < Test::Unit::TestCase

  F = ::LibPath::Internal_::Unix::Form

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
  end
end


# ############################## end of file ############################# #


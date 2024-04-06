#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 4), 'lib')


require 'libpath/util/unix'

require 'test/unit'


class Test_LibPath_Util_Unix_make_path_absolute < Test::Unit::TestCase

  F = ::LibPath::Util::Unix

  def test_nil

    if $DEBUG

      assert_raise(::ArgumentError) { F.make_path_absolute(nil) }
    else

      assert_nil F.make_path_absolute(nil)
    end
  end

  def test_empty

    assert_equal '', F.make_path_absolute('')
  end

  def test_absolute_paths

    assert_equal '/', F.make_path_absolute('/')
    assert_equal '/.', F.make_path_absolute('/.')
    assert_equal '/a', F.make_path_absolute('/a')
    assert_equal '/a/.', F.make_path_absolute('/a/.')
  end

  def test_absolute_paths_with_canonicalisation

    options = { make_canonical: true }

    assert_equal '/', F.make_path_absolute('/', **options)
    assert_equal '/', F.make_path_absolute('/.', **options)
    assert_equal '/a', F.make_path_absolute('/a', **options)
    assert_equal '/a/', F.make_path_absolute('/a/.', **options)
  end

  def test_relative_path_with_fixed_pwd

    pwd = '/some-path/or-other'

    assert_equal '/some-path/or-other/.', F.make_path_absolute('.', pwd: pwd)
    assert_equal '/some-path/or-other/', F.make_path_absolute('.', pwd: pwd, make_canonical: true)

    assert_equal '/some-path/or-other/abc', F.make_path_absolute('abc', pwd: pwd)
    assert_equal '/some-path/or-other/abc', F.make_path_absolute('abc', pwd: pwd, make_canonical: true)

    assert_equal '/some-path/or-other/./abc', F.make_path_absolute('./abc', pwd: pwd)
    assert_equal '/some-path/or-other/abc', F.make_path_absolute('./abc', pwd: pwd, make_canonical: true)

    assert_equal '/some-path/or-other/./abc/', F.make_path_absolute('./abc/', pwd: pwd)
    assert_equal '/some-path/or-other/abc/', F.make_path_absolute('./abc/', pwd: pwd, make_canonical: true)

    assert_equal '/some-path/or-other/def/../abc', F.make_path_absolute('def/../abc', pwd: pwd)
    assert_equal '/some-path/or-other/abc', F.make_path_absolute('def/../abc', pwd: pwd, make_canonical: true)

    assert_equal '/some-path/or-other/def/../abc/', F.make_path_absolute('def/../abc/', pwd: pwd)
    assert_equal '/some-path/or-other/abc/', F.make_path_absolute('def/../abc/', pwd: pwd, make_canonical: true)
  end

  def test_relative_path_with_fixed_home

    home = '/Users/libpath-tester'

    assert_equal '/Users/libpath-tester/.', F.make_path_absolute('~/.', home: home)
    assert_equal '/Users/libpath-tester/', F.make_path_absolute('~/.', home: home, make_canonical: true)

    assert_equal '/Users/libpath-tester/abc', F.make_path_absolute('~/abc', home: home)
    assert_equal '/Users/libpath-tester/abc', F.make_path_absolute('~/abc', home: home, make_canonical: true)

    assert_equal '/Users/libpath-tester/./abc', F.make_path_absolute('~/./abc', home: home)
    assert_equal '/Users/libpath-tester/abc', F.make_path_absolute('~/./abc', home: home, make_canonical: true)

    assert_equal '/Users/libpath-tester/./abc/', F.make_path_absolute('~/./abc/', home: home)
    assert_equal '/Users/libpath-tester/abc/', F.make_path_absolute('~/./abc/', home: home, make_canonical: true)

    assert_equal '/Users/libpath-tester/def/../abc', F.make_path_absolute('~/def/../abc', home: home)
    assert_equal '/Users/libpath-tester/abc', F.make_path_absolute('~/def/../abc', home: home, make_canonical: true)

    assert_equal '/Users/libpath-tester/def/../abc/', F.make_path_absolute('~/def/../abc/', home: home)
    assert_equal '/Users/libpath-tester/abc/', F.make_path_absolute('~/def/../abc/', home: home, make_canonical: true)
  end

  def test_nonhome_tilde_with_fixed_pwd

    pwd = '/some-path/or-other'

    assert_equal '/some-path/or-other/~.', F.make_path_absolute('~.', pwd: pwd)
    assert_equal '/some-path/or-other/~.', F.make_path_absolute('~.', pwd: pwd, make_canonical: true)

    assert_equal '/some-path/or-other/~abc', F.make_path_absolute('~abc', pwd: pwd)
    assert_equal '/some-path/or-other/~abc', F.make_path_absolute('~abc', pwd: pwd, make_canonical: true)

    assert_equal '/some-path/or-other/~./abc', F.make_path_absolute('~./abc', pwd: pwd)
    assert_equal '/some-path/or-other/~./abc', F.make_path_absolute('~./abc', pwd: pwd, make_canonical: true)

    assert_equal '/some-path/or-other/~./abc/', F.make_path_absolute('~./abc/', pwd: pwd)
    assert_equal '/some-path/or-other/~./abc/', F.make_path_absolute('~./abc/', pwd: pwd, make_canonical: true)

    assert_equal '/some-path/or-other/~def/../abc', F.make_path_absolute('~def/../abc', pwd: pwd)
    assert_equal '/some-path/or-other/abc', F.make_path_absolute('~def/../abc', pwd: pwd, make_canonical: true)

    assert_equal '/some-path/or-other/~def/../abc/', F.make_path_absolute('~def/../abc/', pwd: pwd)
    assert_equal '/some-path/or-other/abc/', F.make_path_absolute('~def/../abc/', pwd: pwd, make_canonical: true)
  end
end


# ############################## end of file ############################# #


#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 4), 'lib')

require 'libpath/util/unix'

require 'test/unit'

class Test_LibPath_Util_Unix_combine_paths < Test::Unit::TestCase

	F = ::LibPath::Util::Unix

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

		assert_equal 'a/b/c/d', F.combine_paths('a', 'b', 'c/d')
		assert_equal 'a/b/c/d', F.combine_paths('a', 'b/', 'c/d')

		assert_equal 'a/b', F.combine_paths('', 'a', '', '', 'b')

		assert_equal 'a/ /b', F.combine_paths('', 'a', '', ' ', 'b')
	end

	def test_tail_absolute_cases

		assert_equal '/', F.combine_paths('a', '/')

		assert_equal '/', F.combine_paths('a/b/c/d', '/')

		assert_equal '/', F.combine_paths('a', 'b', '/')
	end

	def test_dots

		assert_equal 'a/.', F.combine_paths('a', '.')
		assert_equal 'a', F.combine_paths('a', '.', elide_single_dots: true)

		assert_equal 'a/b', F.combine_paths('a', '.', 'b', elide_single_dots: true)
		assert_equal 'a/b', F.combine_paths('a', './', 'b', elide_single_dots: true)
		assert_equal '/./b', F.combine_paths('a', '/.', 'b', elide_single_dots: true)
	end

	def test_embedded_absolute_cases

		assert_equal '/a/b/c/d', F.combine_paths('x/y/z', 'z', '/a', 'b', 'c/d')
	end

	def test_multiple_embedded_absolute_cases

		assert_equal '/a/b/c/d', F.combine_paths('x/y/z', '/z', '/a', 'b', 'c/d')
	end
end


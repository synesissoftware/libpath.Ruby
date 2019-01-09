#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 4), 'lib')

require 'libpath/util/windows'

require 'test/unit'

class Test_LibPath_Util_Windows_make_path_canonical < Test::Unit::TestCase

	F = ::LibPath::Util::Windows

	def test_empty

		r	=	F.make_path_canonical ''

		assert_equal '', r
	end

	def test_one_dot

		r	=	F.make_path_canonical '.'

		assert_equal '.', r

		r	=	F.make_path_canonical 'C:.'

		assert_equal 'C:.', r
	end

	def test_two_dots

		r	=	F.make_path_canonical '..'

		assert_equal '..', r

		r	=	F.make_path_canonical 'C:..'

		assert_equal 'C:..', r
	end

	def test_basenames

		r	=	F.make_path_canonical 'a'

		assert_equal 'a', r

		r	=	F.make_path_canonical 'file.ext'

		assert_equal 'file.ext', r

		r	=	F.make_path_canonical '..'

		assert_equal '..', r
	end

	def test_one_dots_directories

		assert_equal 'abc', F.make_path_canonical('./abc')
		assert_equal 'abc', F.make_path_canonical('.\\abc')

		assert_equal 'c:abc', F.make_path_canonical('c:./abc')
		assert_equal 'c:abc', F.make_path_canonical('c:.\\abc')


		assert_equal 'abc', F.make_path_canonical('././abc')
		assert_equal 'abc', F.make_path_canonical('.\\./abc')
		assert_equal 'abc', F.make_path_canonical('.\\.\\abc')

		assert_equal 'abc', F.make_path_canonical('./././././././././abc')

		assert_equal 'abc/', F.make_path_canonical('abc/./')
		assert_equal 'abc\\', F.make_path_canonical('abc\\.\\')
		assert_equal 'abc/', F.make_path_canonical('abc/.\\')

		assert_equal 'abc/', F.make_path_canonical('./abc/./')
	end

	def test_two_dots_directories

		assert_equal '../', F.make_path_canonical('../')
		assert_equal '..\\', F.make_path_canonical('..\\')

		assert_equal '../abc', F.make_path_canonical('../abc')
		assert_equal '..\\abc', F.make_path_canonical('..\\abc')

		assert_equal '.', F.make_path_canonical('abc/..')
		assert_equal '.', F.make_path_canonical('abc\\..')

		assert_equal '.\\', F.make_path_canonical('abc/../')
		assert_equal '.\\', F.make_path_canonical('abc\\..\\')

		assert_equal 'def', F.make_path_canonical('abc/../def')
		assert_equal 'def', F.make_path_canonical('abc\\..\\def')

		assert_equal '.', F.make_path_canonical('abc/../def/..')
		assert_equal '.', F.make_path_canonical('abc\\..\\def\\..')

		assert_equal '.\\', F.make_path_canonical('abc/../def/../')
		assert_equal '.\\', F.make_path_canonical('abc\\../def/..\\')
		assert_equal '.\\', F.make_path_canonical('abc\\../def/../')

		assert_equal '/', F.make_path_canonical('/abc/../def/../')
		assert_equal '/', F.make_path_canonical('/abc\\../def/..\\')
		assert_equal '/', F.make_path_canonical('/abc\\../def/../')

		assert_equal '\\', F.make_path_canonical('\\abc/../def/../')
		assert_equal '\\', F.make_path_canonical('\\abc\\../def/..\\')
		assert_equal '\\', F.make_path_canonical('\\abc\\../def/../')
	end
end


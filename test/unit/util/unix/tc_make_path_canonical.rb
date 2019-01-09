#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 4), 'lib')

require 'libpath/util/unix'

require 'test/unit'

class Test_LibPath_Util_Unix_make_path_canonical < Test::Unit::TestCase

	F = ::LibPath::Util::Unix

	def test_empty

		r	=	F.make_path_canonical ''

		assert_equal '', r
	end

	def test_one_dot

		r	=	F.make_path_canonical '.'

		assert_equal '.', r
	end

	def test_two_dots

		r	=	F.make_path_canonical '..'

		assert_equal '..', r
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

		r	=	F.make_path_canonical './abc'

		assert_equal 'abc', r

		r	=	F.make_path_canonical '././abc'

		assert_equal 'abc', r

		r	=	F.make_path_canonical './././././././././abc'

		assert_equal 'abc', r

		r	=	F.make_path_canonical 'abc/./'

		assert_equal 'abc/', r

		r	=	F.make_path_canonical './abc/./'

		assert_equal 'abc/', r
	end

	def test_two_dots_directories

		r	=	F.make_path_canonical '../'

		assert_equal '../', r

		r	=	F.make_path_canonical '../abc'

		assert_equal '../abc', r

		r	=	F.make_path_canonical 'abc/..'

		assert_equal '.', r

		r	=	F.make_path_canonical 'abc/../'

		assert_equal './', r

		r	=	F.make_path_canonical 'abc/../def'

		assert_equal 'def', r

		r	=	F.make_path_canonical 'abc/../def/..'

		assert_equal '.', r

		r	=	F.make_path_canonical 'abc/../def/../'

		assert_equal './', r
	end
end


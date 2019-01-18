#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 4), 'lib')

require 'libpath/util/unix'

require 'test/unit'

class Test_LibPath_Util_Unix_make_path_canonical < Test::Unit::TestCase

	F = ::LibPath::Util::Unix

	def test_empty

		assert_equal '', F.make_path_canonical('')
	end

	def test_one_dot

		assert_equal '.', F.make_path_canonical('.')
		assert_equal './', F.make_path_canonical('./')
		assert_equal '.', F.make_path_canonical('./.')
		assert_equal '.', F.make_path_canonical('./.')
		assert_equal './', F.make_path_canonical('././')
		assert_equal '.', F.make_path_canonical('././.')
		assert_equal './', F.make_path_canonical('./././')
	end

	def test_two_dots

		assert_equal '..', F.make_path_canonical('..')
		assert_equal '../', F.make_path_canonical('../')
		assert_equal '../', F.make_path_canonical('../.')
		assert_equal '../', F.make_path_canonical('.././')
		assert_equal '../', F.make_path_canonical('.././.')
	end

	def test_basenames

		assert_equal 'a', F.make_path_canonical('a')

		assert_equal 'file.ext', F.make_path_canonical('file.ext')

		assert_equal '..', F.make_path_canonical('..')
	end

	def test_one_dots_directories

		assert_equal 'abc', F.make_path_canonical('./abc')

		assert_equal 'abc', F.make_path_canonical('././abc')

		assert_equal 'abc', F.make_path_canonical('./././././././././abc')

		assert_equal 'abc/', F.make_path_canonical('abc/./')

		assert_equal 'abc/', F.make_path_canonical('./abc/./')
	end

	def test_two_dots_directories

		assert_equal '../', F.make_path_canonical('../')

		assert_equal '../abc', F.make_path_canonical('../abc')

		assert_equal '.', F.make_path_canonical('abc/..')

		assert_equal './', F.make_path_canonical('abc/../')

		assert_equal 'def', F.make_path_canonical('abc/../def')

		assert_equal '.', F.make_path_canonical('abc/../def/..')

		assert_equal './', F.make_path_canonical('abc/../def/../')
	end
end


#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 4), 'lib')

require 'libpath/util/unix'

require 'test/unit'

class Test_LibPath_Util_Unix_derive_relative_path < Test::Unit::TestCase

	M = ::LibPath::Util::Unix

	def test_nils_and_empties

		# to get nowhere from nowhere, go nowhere
		assert_nil M.derive_relative_path(nil, nil)
		assert_nil M.derive_relative_path('', nil)
		assert_equal '', M.derive_relative_path('', '')
		assert_equal '', M.derive_relative_path(nil, '')

		# to get somewhere from nowhere, just go there
		assert_equal 'abc', M.derive_relative_path(nil, 'abc')
		assert_equal 'abc', M.derive_relative_path('', 'abc')

		# to get nowhere from anywhere else, go nowhere
		assert_nil M.derive_relative_path('dir', nil)
		assert_equal '', M.derive_relative_path('dir', '')
	end

	def test_same_location

		assert_equal '.', M.derive_relative_path('.', '.')
		assert_equal '.', M.derive_relative_path('..', '..')

		assert_equal '.', M.derive_relative_path('abc', 'abc')
		assert_equal './', M.derive_relative_path('abc/', 'abc/')
		assert_equal './', M.derive_relative_path('abc', 'abc/')

		assert_equal './', M.derive_relative_path('/', '/')

		assert_equal '.', M.derive_relative_path('./abc', 'abc')
		assert_equal '.', M.derive_relative_path('./abc/', 'abc')
		assert_equal './', M.derive_relative_path('./abc', 'abc/')
		assert_equal './', M.derive_relative_path('./abc/', 'abc/')

		assert_equal '.', M.derive_relative_path('/abc', '/abc')
		assert_equal '.', M.derive_relative_path('/abc/', '/abc')
		assert_equal './', M.derive_relative_path('/abc/', '/abc/')
		assert_equal '../', M.derive_relative_path('/abc/', '/')

		assert_equal '../../', M.derive_relative_path('/abc/def/', '/')
		assert_equal '../../', M.derive_relative_path('/abc/def/', '/')
	end

	def test_from_here

		assert_equal 'abc', M.derive_relative_path('.', 'abc')
		assert_equal 'abc', M.derive_relative_path('./', 'abc')
		assert_equal 'abc/', M.derive_relative_path('.', 'abc/')
		assert_equal 'abc/', M.derive_relative_path('./', 'abc/')

		assert_equal('abc/', M.derive_relative_path('/dir1/dir2', '/dir1/dir2/abc/'))
		assert_equal('.', M.derive_relative_path('/dir1/dir2/abc', '/dir1/dir2/abc'))
		assert_equal('./', M.derive_relative_path('/dir1/dir2/abc', '/dir1/dir2/abc/'))
	end

	def test_ones_above

		assert_equal '../', M.derive_relative_path('.', '..')

		assert_equal '..', M.derive_relative_path('abc/def', 'abc')

		assert_equal '..', M.derive_relative_path('abc/def/ghi', 'abc/def')
		assert_equal '../', M.derive_relative_path('abc/def/ghi', 'abc/def/')

		assert_equal '..', M.derive_relative_path('abc/def/./ghi', 'abc/def')
		assert_equal '..', M.derive_relative_path('abc/def/ghi/jkl/..', 'abc/def')
		assert_equal '..', M.derive_relative_path('abc/def/ghi/jkl/../', 'abc/def')
		assert_equal '../', M.derive_relative_path('abc/def/ghi/jkl/..', 'abc/def/')

		assert_equal '../..', M.derive_relative_path('abc/def/ghi/jkl/', 'abc/def')
	end

	def test_ones_below

		assert_equal 'dir-1/', M.derive_relative_path('..', '.', pwd: '/dir-1/')

		assert_equal '../', M.derive_relative_path('.', '..', pwd: '/dir-1/')

		assert_equal 'def', M.derive_relative_path('abc', 'abc/def')

		assert_equal 'def/ghi', M.derive_relative_path('abc', 'abc/def/ghi')
	end

	def test_ones_across

		assert_equal '../e-1', M.derive_relative_path('abc/d-1', 'abc/e-1')
		assert_equal '../e-1', M.derive_relative_path('abc/d-1/', 'abc/e-1')

		assert_equal '../e-1/e-2', M.derive_relative_path('abc/d-1/', 'abc/e-1/e-2')
		assert_equal '../../e-1/e-2', M.derive_relative_path('abc/d-1/d-2/', 'abc/e-1/e-2')
	end

	def test_simple_cases

		assert_equal 'def', M.derive_relative_path('/abc', '/abc/def')
	end

	def test_absolute_path_cases

		assert_equal '../../def', M.derive_relative_path('ghi', '/def', pwd: '/abc')

		assert_equal '../def', M.derive_relative_path('abc', '/def', pwd: '/')
	end

	def test_both_relative

		assert_equal '../def', M.derive_relative_path('abc', 'def', pwd: '/')
	end
end


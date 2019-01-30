#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 3), 'lib')

require 'libpath/internal_/array'

require 'test/unit'

class Test_Internal_Array_index < Test::Unit::TestCase

	A = ::LibPath::Internal_::Array

	def test_empty_array

		assert_nil A.index([], 1)
		assert_nil A.index([], 1, 1)
	end

	def test_simple_find

		assert_equal 0, A.index([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ], 0)
		assert_equal 1, A.index([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ], 1)

		assert_equal 0, A.index([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ], 0, 0)
		assert_equal 1, A.index([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ], 1, 0)
		assert_equal 1, A.index([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ], 1, 1)
	end

	def test_not_found

		assert_nil A.index([ 0, 2, 4, 6, 8 ], 1)
		assert_nil A.index([ 0, 2, 4, 6, 8 ], 1, 1)
	end

	def test_not_found_after_index

		assert_nil A.index([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ], 1, 2)
	end
end

class Test_Internal_Array_index2 < Test::Unit::TestCase

	A = ::LibPath::Internal_::Array

	def test_empty_array

		assert_nil A.index2([], 0, 1)
		assert_nil A.index2([], 0, 1, 1)
	end

	def test_simple_find

		assert_equal 0, A.index2([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ], 0, 1)
		assert_equal 1, A.index2([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ], 2, 1)

		assert_equal 0, A.index2([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ], 1, 0, 0)
		assert_equal 1, A.index2([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ], 2, 1, 0)
		assert_equal 1, A.index2([ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ], 8, 1, 1)
	end

end


#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 5), 'lib')

require 'libpath/internal_/windows/form'

require 'test/unit'

require 'xqsr3/extensions/test/unit'

class Test_Internal_Windows_Form_slash_functions < Test::Unit::TestCase

	F = ::LibPath::Internal_::Windows::Form

	def test_char_is_path_name_separator

		assert_false F.char_is_path_name_separator('')
		assert_false F.char_is_path_name_separator('a')

		assert F.char_is_path_name_separator('/')
		assert F.char_is_path_name_separator('\\')
	end

	def test_append_trailing_slash

		assert_equal '\\', F.append_trailing_slash('')
		assert_equal '/', F.append_trailing_slash('/')
		assert_equal 'a\\', F.append_trailing_slash('a')
		assert_equal 'a/', F.append_trailing_slash('a/')
	end

	def test_get_trailing_slash

		assert_nil F.get_trailing_slash('')
		assert_equal '/', F.get_trailing_slash('/')
		assert_nil F.get_trailing_slash('a')
		assert_equal '\\', F.get_trailing_slash('\\')
		assert_equal '/', F.get_trailing_slash('a/')
	end

	def test_has_trailing_slash

		assert_false F.has_trailing_slash?('')
		assert_true F.has_trailing_slash?('/')
		assert_false F.has_trailing_slash?('a')
		assert_true F.has_trailing_slash?('\\')
		assert_true F.has_trailing_slash?('a/')
	end

	def test_trim_trailing_slash

		assert_equal '', F.trim_trailing_slash('')
		assert_equal '', F.trim_trailing_slash('/')
		assert_equal 'a', F.trim_trailing_slash('a')
		assert_equal '', F.trim_trailing_slash('\\')
		assert_equal 'a', F.trim_trailing_slash('a/')
		assert_equal 'a', F.trim_trailing_slash('a\\')
	end
end



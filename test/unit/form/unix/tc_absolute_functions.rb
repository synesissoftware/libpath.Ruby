#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 4), 'lib')

require 'libpath/form/unix'

require 'test/unit'

require 'xqsr3/extensions/test/unit'

class Test_existence_of_namespace_LibPath_Form_Unix < Test::Unit::TestCase

	def test_LibPath_module_exists

		assert defined?(::LibPath)
	end

	def test_LibPath_Form_module_exists

		assert defined?(::LibPath::Form)
	end

	def test_LibPath_Form_Unix_module_exists

		assert defined?(::LibPath::Form::Unix)
	end
end

class Test_classify_path_Unix < Test::Unit::TestCase

	include ::LibPath::Form::Unix

	def test_with_nil

		if $DEBUG

			assert_raise(::ArgumentError) { classify_path(nil) }
		else

			assert_nil classify_path(nil)
		end
	end

	def test_empty

		assert_nil classify_path('')
	end

	def test_absolute

		assert_equal :absolute, classify_path('/')

		assert_equal :absolute, classify_path('/abc')
	end

	def test_homed

		assert_equal :homed, classify_path('~')

		assert_equal :homed, classify_path('~/')

		assert_equal :homed, classify_path('~/abc')
	end

	def test_relative

		assert_equal :relative, classify_path('abc')

		assert_equal :relative, classify_path('~~')
	end
end

class Test_path_is_absolute_Unix < Test::Unit::TestCase

	include ::LibPath::Form::Unix

	if $DEBUG

		def test_with_nil

			assert_raise(::ArgumentError) { path_is_absolute?(nil) }
		end
	end

	def test_empty

		assert_false path_is_absolute?('')
	end

	def test_absolute_paths_from_root

		assert path_is_absolute?('/')
		assert path_is_absolute?('//')
		assert path_is_absolute?('/abc')
	end

	def test_absolute_paths_from_home

		assert path_is_absolute?('~')
		assert path_is_absolute?('~/')
		assert path_is_absolute?('~/abc')
	end

	def test_relative_paths

		assert_false path_is_absolute?('abc')
		assert_false path_is_absolute?('abc/')
		assert_false path_is_absolute?('a/')

		assert_false path_is_absolute?('~abc')
	end
end

class Test_path_is_homed_Unix < Test::Unit::TestCase

	include ::LibPath::Form::Unix

	if $DEBUG

		def test_with_nil

			assert_raise(::ArgumentError) { path_is_homed?(nil) }
		end
	end

	def test_empty

		assert_false path_is_homed?('')
	end

	def test_absolute_paths_from_root

		assert_false path_is_homed?('/')
		assert_false path_is_homed?('//')
		assert_false path_is_homed?('/abc')
	end

	def test_absolute_paths_from_home

		assert path_is_homed?('~')
		assert path_is_homed?('~/')
		assert path_is_homed?('~/abc')
	end

	def test_relative_paths

		assert_false path_is_homed?('abc')
		assert_false path_is_homed?('abc/')
		assert_false path_is_homed?('a/')

		assert_false path_is_homed?('~abc')
	end
end

class Test_path_is_rooted_Unix < Test::Unit::TestCase

	include ::LibPath::Form::Unix

	if $DEBUG

		def test_with_nil

			assert_raise(::ArgumentError) { path_is_rooted?(nil) }
		end
	end

	def test_empty

		assert_false path_is_rooted?('')
	end

	def test_absolute_paths_from_root

		assert path_is_rooted?('/')
		assert path_is_rooted?('//')
		assert path_is_rooted?('/abc')
	end

	def test_absolute_paths_from_home

		assert_false path_is_rooted?('~')
		assert_false path_is_rooted?('~/')
		assert_false path_is_rooted?('~/abc')
	end

	def test_relative_paths

		assert_false path_is_rooted?('abc')
		assert_false path_is_rooted?('abc/')
		assert_false path_is_rooted?('a/')

		assert_false path_is_rooted?('~abc')
	end
end


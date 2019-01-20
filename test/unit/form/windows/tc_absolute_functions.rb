#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 4), 'lib')

require 'libpath/form/windows'

require 'test/unit'

require 'xqsr3/extensions/test/unit'

class Test_existence_of_namespace_LibPath_Form_Windows < Test::Unit::TestCase

	def test_LibPath_module_exists

		assert defined?(::LibPath)
	end

	def test_LibPath_Form_module_exists

		assert defined?(::LibPath::Form)
	end

	def test_LibPath_Form_Windows_module_exists

		assert defined?(::LibPath::Form::Windows)
	end
end

class Test_path_is_absolute_Windows < Test::Unit::TestCase

	include ::LibPath::Form::Windows

	if $DEBUG

		def test_with_nil

			assert_raise(::ArgumentError) { path_is_absolute?(nil) }
		end
	end

	def test_empty

		assert_false path_is_absolute?('')
	end

	def test_absolute_paths_from_UNC

		assert_false path_is_absolute?('\\\\')
		assert_false path_is_absolute?('\\\\server')
		assert_false path_is_absolute?('\\\\server\\')
		assert_false path_is_absolute?('\\\\server\\share')

		assert path_is_absolute?('\\\\server\\the-share_name\\')
		assert path_is_absolute?('\\\\server\\the-share_name\\\\')
		assert path_is_absolute?('\\\\server\\the-share_name\\dir')
		assert path_is_absolute?('\\\\server\\the-share_name\\dir\\')

		assert path_is_absolute?('\\\\101.2.303.4\\the-share_name\\')
		assert path_is_absolute?('\\\\101.2.303.4\\the-share_name\\\\')
		assert path_is_absolute?('\\\\101.2.303.4\\the-share_name\\dir')
		assert path_is_absolute?('\\\\101.2.303.4\\the-share_name\\dir\\')

		assert path_is_absolute?('\\\\::1/128\\the-share_name\\')
		assert path_is_absolute?('\\\\::1/128\\the-share_name\\\\')
		assert path_is_absolute?('\\\\::1/128\\the-share_name\\dir')
		assert path_is_absolute?('\\\\::1/128\\the-share_name\\dir\\')
	end

	def test_absolute_paths_from_drive

		assert path_is_absolute?('C:\\')
		assert path_is_absolute?('C:\\abc')
		assert path_is_absolute?('C:\\abc\\')

		assert_false path_is_absolute?('C:')
		assert_false path_is_absolute?('C:abc')
		assert_false path_is_absolute?('C:abc\\')
	end

	def test_absolute_paths_from_root

		assert_false path_is_absolute?('\\')
		assert_false path_is_absolute?('\\\\')
		assert_false path_is_absolute?('\\abc')

		assert_false path_is_absolute?('/')
		assert_false path_is_absolute?('//')
		assert_false path_is_absolute?('/abc')
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

class Test_path_is_homed_Windows < Test::Unit::TestCase

	include ::LibPath::Form::Windows

	if $DEBUG

		def test_with_nil

			assert_raise(::ArgumentError) { path_is_homed?(nil) }
		end
	end

	def test_empty

		assert_false path_is_homed?('')
	end

	def test_absolute_paths_from_UNC

		assert_false path_is_homed?('\\\\')
		assert_false path_is_homed?('\\\\server')
		assert_false path_is_homed?('\\\\server\\')
		assert_false path_is_homed?('\\\\server\\share')

		assert_false path_is_homed?('\\\\server\\the-share_name\\')
		assert_false path_is_homed?('\\\\server\\the-share_name\\\\')
		assert_false path_is_homed?('\\\\server\\the-share_name\\dir')
		assert_false path_is_homed?('\\\\server\\the-share_name\\dir\\')

		assert_false path_is_homed?('\\\\101.2.303.4\\the-share_name\\')
		assert_false path_is_homed?('\\\\101.2.303.4\\the-share_name\\\\')
		assert_false path_is_homed?('\\\\101.2.303.4\\the-share_name\\dir')
		assert_false path_is_homed?('\\\\101.2.303.4\\the-share_name\\dir\\')

		assert_false path_is_homed?('\\\\::1/128\\the-share_name\\')
		assert_false path_is_homed?('\\\\::1/128\\the-share_name\\\\')
		assert_false path_is_homed?('\\\\::1/128\\the-share_name\\dir')
		assert_false path_is_homed?('\\\\::1/128\\the-share_name\\dir\\')
	end

	def test_absolute_paths_from_drive

		assert_false path_is_homed?('C:\\')
		assert_false path_is_homed?('C:\\abc')
		assert_false path_is_homed?('C:\\abc\\')
	end

	def test_absolute_paths_from_root

		assert_false path_is_homed?('\\')
		assert_false path_is_homed?('\\\\')
		assert_false path_is_homed?('\\abc')

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

class Test_path_is_rooted_Windows < Test::Unit::TestCase

	include ::LibPath::Form::Windows

	if $DEBUG

		def test_with_nil

			assert_raise(::ArgumentError) { path_is_rooted?(nil) }
		end
	end

	def test_empty

		assert_false path_is_rooted?('')
	end

	def test_absolute_paths_from_UNC

		assert_false path_is_rooted?('\\\\')
		assert_false path_is_rooted?('\\\\server')
		assert_false path_is_rooted?('\\\\server\\')
		assert_false path_is_rooted?('\\\\server\\share')

		assert path_is_rooted?('\\\\server\\the-share_name\\')
		assert path_is_rooted?('\\\\server\\the-share_name\\\\')
		assert path_is_rooted?('\\\\server\\the-share_name\\dir')
		assert path_is_rooted?('\\\\server\\the-share_name\\dir\\')

		assert path_is_rooted?('\\\\101.2.303.4\\the-share_name\\')
		assert path_is_rooted?('\\\\101.2.303.4\\the-share_name\\\\')
		assert path_is_rooted?('\\\\101.2.303.4\\the-share_name\\dir')
		assert path_is_rooted?('\\\\101.2.303.4\\the-share_name\\dir\\')

		assert path_is_rooted?('\\\\::1/128\\the-share_name\\')
		assert path_is_rooted?('\\\\::1/128\\the-share_name\\\\')
		assert path_is_rooted?('\\\\::1/128\\the-share_name\\dir')
		assert path_is_rooted?('\\\\::1/128\\the-share_name\\dir\\')
	end

	def test_absolute_paths_from_drive

		assert path_is_rooted?('C:\\')
		assert path_is_rooted?('C:\\abc')
		assert path_is_rooted?('C:\\abc\\')

		assert_false path_is_rooted?('C:')
		assert_false path_is_rooted?('C:abc')
		assert_false path_is_rooted?('C:abc\\')
	end

	def test_absolute_paths_from_root

		assert path_is_rooted?('\\')
		assert_false path_is_rooted?('\\\\')
		assert path_is_rooted?('\\abc')

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

class Test_path_is_UNC_Windows < Test::Unit::TestCase

	include ::LibPath::Form::Windows

	if $DEBUG

		def test_with_nil

			assert_raise(::ArgumentError) { path_is_UNC?(nil) }
		end
	end

	def test_empty

		assert_false path_is_UNC?('')
	end

	def test_absolute_paths_from_drive

		assert_false path_is_UNC?('C:\\')
		assert_false path_is_UNC?('C:\\\\')
		assert_false path_is_UNC?('C:\\abc\\')
	end

	def test_absolute_paths_from_UNC

		assert_false path_is_UNC?('\\\\')
		assert_false path_is_UNC?('\\\\server')
		assert_false path_is_UNC?('\\\\server\\')
		assert_false path_is_UNC?('\\\\server\\share')

		assert path_is_UNC?('\\\\server\\the-share_name\\')
		assert path_is_UNC?('\\\\server\\the-share_name\\\\')
		assert path_is_UNC?('\\\\server\\the-share_name\\dir')
		assert path_is_UNC?('\\\\server\\the-share_name\\dir\\')

		assert path_is_UNC?('\\\\101.2.303.4\\the-share_name\\')
		assert path_is_UNC?('\\\\101.2.303.4\\the-share_name\\\\')
		assert path_is_UNC?('\\\\101.2.303.4\\the-share_name\\dir')
		assert path_is_UNC?('\\\\101.2.303.4\\the-share_name\\dir\\')

		assert path_is_UNC?('\\\\::1/128\\the-share_name\\')
		assert path_is_UNC?('\\\\::1/128\\the-share_name\\\\')
		assert path_is_UNC?('\\\\::1/128\\the-share_name\\dir')
		assert path_is_UNC?('\\\\::1/128\\the-share_name\\dir\\')
	end

	def test_absolute_paths_from_root

		assert_false path_is_UNC?('\\')
		assert_false path_is_UNC?('\\\\')
		assert_false path_is_UNC?('\\abc')

		assert_false path_is_UNC?('/')
		assert_false path_is_UNC?('//')
		assert_false path_is_UNC?('/abc')
	end

	def test_absolute_paths_from_home

		assert_false path_is_UNC?('~')
		assert_false path_is_UNC?('~/')
		assert_false path_is_UNC?('~/abc')
	end

	def test_relative_paths

		assert_false path_is_UNC?('abc')
		assert_false path_is_UNC?('abc/')
		assert_false path_is_UNC?('a/')

		assert_false path_is_UNC?('~abc')
	end
end

class Test_path_is_drived_Windows < Test::Unit::TestCase

	include ::LibPath::Form::Windows

	if $DEBUG

		def test_with_nil

			assert_raise(::ArgumentError) { path_is_drived?(nil) }
		end
	end

	def test_empty

		assert_nil path_is_drived?('')
	end

	def test_absolute_paths_from_drive

		assert_equal 2, path_is_drived?('C:')
		assert_equal 3, path_is_drived?('C:\\')
		assert_equal 3, path_is_drived?('C:/')
		assert_equal 3, path_is_drived?('C:\\\\')
		assert_equal 3, path_is_drived?('C:\\abc\\')

		assert_equal 6, path_is_drived?('\\\\?\\C:')
		assert_equal 7, path_is_drived?('\\\\?\\C:\\')
		assert_equal 7, path_is_drived?('\\\\?\\C:/')
		assert_equal 7, path_is_drived?('\\\\?\\C:\\\\')
		assert_equal 7, path_is_drived?('\\\\?\\C:\\abc\\')
	end

	def test_absolute_paths_from_other_UNC

		assert_nil path_is_drived?('\\\\')
		assert_nil path_is_drived?('\\\\server')
		assert_nil path_is_drived?('\\\\server\\')
		assert_nil path_is_drived?('\\\\server\\share')

		assert_nil path_is_drived?('\\\\server\\the-share_name\\')
		assert_nil path_is_drived?('\\\\server\\the-share_name\\\\')
		assert_nil path_is_drived?('\\\\server\\the-share_name\\dir')
		assert_nil path_is_drived?('\\\\server\\the-share_name\\dir\\')

		assert_nil path_is_drived?('\\\\101.2.303.4\\the-share_name\\')
		assert_nil path_is_drived?('\\\\101.2.303.4\\the-share_name\\\\')
		assert_nil path_is_drived?('\\\\101.2.303.4\\the-share_name\\dir')
		assert_nil path_is_drived?('\\\\101.2.303.4\\the-share_name\\dir\\')

		assert_nil path_is_drived?('\\\\::1/128\\the-share_name\\')
		assert_nil path_is_drived?('\\\\::1/128\\the-share_name\\\\')
		assert_nil path_is_drived?('\\\\::1/128\\the-share_name\\dir')
		assert_nil path_is_drived?('\\\\::1/128\\the-share_name\\dir\\')
	end

	def test_absolute_paths_from_root

		assert_nil path_is_drived?('\\')
		assert_nil path_is_drived?('\\\\')
		assert_nil path_is_drived?('\\abc')

		assert_nil path_is_drived?('/')
		assert_nil path_is_drived?('//')
		assert_nil path_is_drived?('/abc')
	end

	def test_absolute_paths_from_home

		assert_nil path_is_drived?('~')
		assert_nil path_is_drived?('~/')
		assert_nil path_is_drived?('~/abc')
	end

	def test_relative_paths

		assert_nil path_is_drived?('abc')
		assert_nil path_is_drived?('abc/')
		assert_nil path_is_drived?('a/')

		assert_nil path_is_drived?('~abc')
	end
end


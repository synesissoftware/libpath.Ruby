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

class Test_classify_path_Windows < Test::Unit::TestCase

	include ::LibPath::Form::Windows

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

	def test_drived

		assert_equal :drived, classify_path('C:abc')
		assert_equal :drived, classify_path('C:abc/')
		assert_equal :drived, classify_path('C:abc\\')

		assert_equal :drived, classify_path('\\\\?\\C:abc')
		assert_equal :drived, classify_path('\\\\?\\C:abc/')
		assert_equal :drived, classify_path('\\\\?\\C:abc\\')

		assert_equal :drived, classify_path('\\\\server\\share')

		assert_equal :drived, classify_path('\\\\?\\server\\share')
	end

	def test_absolute

		assert_equal :absolute, classify_path('C:/')
		assert_equal :absolute, classify_path('C:\\')

		assert_equal :absolute, classify_path('C:/abc')
		assert_equal :absolute, classify_path('C:\\abc')


		assert_equal :absolute, classify_path('\\\\server\\share/')
		assert_equal :absolute, classify_path('\\\\server\\share\\')

		assert_equal :absolute, classify_path('\\\\server\\share/abc')
		assert_equal :absolute, classify_path('\\\\server\\share\\abc')


		assert_equal :absolute, classify_path('\\\\?\\C:/')
		assert_equal :absolute, classify_path('\\\\?\\C:\\')

		assert_equal :absolute, classify_path('\\\\?\\C:/abc')
		assert_equal :absolute, classify_path('\\\\?\\C:\\abc')


		assert_equal :absolute, classify_path('\\\\?\\server\\share/')
		assert_equal :absolute, classify_path('\\\\?\\server\\share\\')

		assert_equal :absolute, classify_path('\\\\?\\server\\share/abc')
		assert_equal :absolute, classify_path('\\\\?\\server\\share\\abc')


		assert_equal :absolute, classify_path('\\\\?\\UNC\\server\\share/')
		assert_equal :absolute, classify_path('\\\\?\\UNC\\server\\share\\')

		assert_equal :absolute, classify_path('\\\\?\\UNC\\server\\share/abc')
		assert_equal :absolute, classify_path('\\\\?\\UNC\\server\\share\\abc')
	end

	def test_rooted

		assert_equal :rooted, classify_path('/')
		assert_equal :rooted, classify_path('\\')

		assert_equal :rooted, classify_path('/abc')
		assert_equal :rooted, classify_path('\\abc')
	end

	def test_homed

		assert_equal :homed, classify_path('~')

		assert_equal :homed, classify_path('~/')
		assert_equal :homed, classify_path('~\\')

		assert_equal :homed, classify_path('~/abc')
		assert_equal :homed, classify_path('~\\abc')
	end

	def test_relative

		assert_equal :relative, classify_path('abc')

		assert_equal :relative, classify_path('~~')
	end
end

class Test_name_is_malformed_Windows < Test::Unit::TestCase

	include ::LibPath::Form::Windows

	def test_with_nil

		assert name_is_malformed?(nil)
	end

	def test_empty

		assert_false name_is_malformed?('')
	end

	def test_absolute_paths_from_root

		assert_false name_is_malformed?('/')
		assert_false name_is_malformed?('//')
		assert_false name_is_malformed?('/abc')
	end

	def test_absolute_paths_from_home

		assert_false name_is_malformed?('~')
		assert_false name_is_malformed?('~/')
		assert_false name_is_malformed?('~/abc')
	end

	def test_relative_paths

		assert_false name_is_malformed?('abc')
		assert_false name_is_malformed?('abc/')
		assert_false name_is_malformed?('a/')

		assert_false name_is_malformed?('~abc')
	end

	def test_innate_invalid_characters

		assert name_is_malformed?("\0")
		assert name_is_malformed?("a\0")
		assert name_is_malformed?("\0a")

		assert name_is_malformed?("\0", reject_shell_characters: true)
		assert name_is_malformed?("a\0", reject_shell_characters: true)
		assert name_is_malformed?("\0a", reject_shell_characters: true)
	end

	def test_shell_invalid_characters

		assert_false name_is_malformed?('*')
		assert_false name_is_malformed?('?')
		assert_false name_is_malformed?('|')

		assert name_is_malformed?('*', reject_shell_characters: true)
		assert name_is_malformed?('?', reject_shell_characters: true)
		assert name_is_malformed?('|', reject_shell_characters: true)
	end

	def test_path_name_separators

		assert_false name_is_malformed?('/')
		assert_false name_is_malformed?('\\')

		assert name_is_malformed?('/', reject_path_name_separators: true)
		assert name_is_malformed?('\\', reject_path_name_separators: true)
	end

	def test_path_separators

		assert_false name_is_malformed?(';')

		assert name_is_malformed?(';', reject_path_separators: true)
	end

	def test_partial_UNC

		assert_false name_is_malformed?('\\')
		assert name_is_malformed?('\\\\')
		assert name_is_malformed?('\\\\server')
		assert name_is_malformed?('\\\\server\\')
		assert_false name_is_malformed?('\\\\server\\share')
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

		# form 2

		assert_false path_is_absolute?('\\\\server\\share')
		assert path_is_absolute?('\\\\server\\share\\')
		assert path_is_absolute?('\\\\server\\share/')

		assert_false path_is_absolute?('\\\\server\\the-share_name')
		assert path_is_absolute?('\\\\server\\the-share_name/')
		assert path_is_absolute?('\\\\server\\the-share_name\\')
		assert path_is_absolute?('\\\\server\\the-share_name\\\\')
		assert path_is_absolute?('\\\\server\\the-share_name\\dir')
		assert path_is_absolute?('\\\\server\\the-share_name\\dir\\')

		assert_false path_is_absolute?('\\\\101.2.303.4\\the-share_name')
		assert path_is_absolute?('\\\\101.2.303.4\\the-share_name/')
		assert path_is_absolute?('\\\\101.2.303.4\\the-share_name\\')
		assert path_is_absolute?('\\\\101.2.303.4\\the-share_name\\\\')
		assert path_is_absolute?('\\\\101.2.303.4\\the-share_name\\dir')
		assert path_is_absolute?('\\\\101.2.303.4\\the-share_name\\dir\\')

		assert_false path_is_absolute?('\\\\::1/128\\the-share_name')
		assert path_is_absolute?('\\\\::1/128\\the-share_name/')
		assert path_is_absolute?('\\\\::1/128\\the-share_name\\')
		assert path_is_absolute?('\\\\::1/128\\the-share_name\\\\')
		assert path_is_absolute?('\\\\::1/128\\the-share_name\\dir')
		assert path_is_absolute?('\\\\::1/128\\the-share_name\\dir\\')

		# form 4

		assert_false path_is_absolute?('\\\\?\\server\\the-share_name')
		assert path_is_absolute?('\\\\?\\server\\the-share_name/')
		assert path_is_absolute?('\\\\?\\server\\the-share_name\\')
		assert path_is_absolute?('\\\\?\\server\\the-share_name\\\\')
		assert path_is_absolute?('\\\\?\\server\\the-share_name\\dir')
		assert path_is_absolute?('\\\\?\\server\\the-share_name\\dir\\')

		assert_false path_is_absolute?('\\\\?\\101.2.303.4\\the-share_name')
		assert path_is_absolute?('\\\\?\\101.2.303.4\\the-share_name/')
		assert path_is_absolute?('\\\\?\\101.2.303.4\\the-share_name\\')
		assert path_is_absolute?('\\\\?\\101.2.303.4\\the-share_name\\\\')
		assert path_is_absolute?('\\\\?\\101.2.303.4\\the-share_name\\dir')
		assert path_is_absolute?('\\\\?\\101.2.303.4\\the-share_name\\dir\\')

		assert_false path_is_absolute?('\\\\?\\::1/128\\the-share_name')
		assert path_is_absolute?('\\\\?\\::1/128\\the-share_name/')
		assert path_is_absolute?('\\\\?\\::1/128\\the-share_name\\')
		assert path_is_absolute?('\\\\?\\::1/128\\the-share_name\\\\')
		assert path_is_absolute?('\\\\?\\::1/128\\the-share_name\\dir')
		assert path_is_absolute?('\\\\?\\::1/128\\the-share_name\\dir\\')

		# form 5

		assert_false path_is_absolute?('\\\\?\\UNC\\server\\the-share_name')
		assert path_is_absolute?('\\\\?\\UNC\\server\\the-share_name/')
		assert path_is_absolute?('\\\\?\\UNC\\server\\the-share_name\\')
		assert path_is_absolute?('\\\\?\\UNC\\server\\the-share_name\\\\')
		assert path_is_absolute?('\\\\?\\UNC\\server\\the-share_name\\dir')
		assert path_is_absolute?('\\\\?\\UNC\\server\\the-share_name\\dir\\')

		assert_false path_is_absolute?('\\\\?\\UNC\\101.2.303.4\\the-share_name')
		assert path_is_absolute?('\\\\?\\UNC\\101.2.303.4\\the-share_name/')
		assert path_is_absolute?('\\\\?\\UNC\\101.2.303.4\\the-share_name\\')
		assert path_is_absolute?('\\\\?\\UNC\\101.2.303.4\\the-share_name\\\\')
		assert path_is_absolute?('\\\\?\\UNC\\101.2.303.4\\the-share_name\\dir')
		assert path_is_absolute?('\\\\?\\UNC\\101.2.303.4\\the-share_name\\dir\\')

		assert_false path_is_absolute?('\\\\?\\UNC\\::1/128\\the-share_name')
		assert path_is_absolute?('\\\\?\\UNC\\::1/128\\the-share_name/')
		assert path_is_absolute?('\\\\?\\UNC\\::1/128\\the-share_name\\')
		assert path_is_absolute?('\\\\?\\UNC\\::1/128\\the-share_name\\\\')
		assert path_is_absolute?('\\\\?\\UNC\\::1/128\\the-share_name\\dir')
		assert path_is_absolute?('\\\\?\\UNC\\::1/128\\the-share_name\\dir\\')
	end

	def test_absolute_paths_from_drive

		# form 1

		assert path_is_absolute?('C:\\')
		assert path_is_absolute?('C:\\abc')
		assert path_is_absolute?('C:\\abc\\')

		assert_false path_is_absolute?('C:')
		assert_false path_is_absolute?('C:abc')
		assert_false path_is_absolute?('C:abc\\')

		# form 3

		assert path_is_absolute?('\\\\?\\C:\\')
		assert path_is_absolute?('\\\\?\\C:\\abc')
		assert path_is_absolute?('\\\\?\\C:\\abc\\')

		assert_false path_is_absolute?('\\\\?\\C:')
		assert_false path_is_absolute?('\\\\?\\C:abc')
		assert_false path_is_absolute?('\\\\?\\C:abc\\')
	end

	def test_absolute_paths_from_device

		# form 6

		assert_false path_is_absolute?('\\\\.\\')
		assert_false path_is_absolute?('\\\\.\\{device-id}')
		assert_false path_is_absolute?('\\\\.\\{device-id}/')
		assert path_is_absolute?('\\\\.\\{device-id}\\')
		assert path_is_absolute?('\\\\.\\{device-id}\\\\')
		assert path_is_absolute?('\\\\.\\{device-id}\\dir')
		assert path_is_absolute?('\\\\.\\{device-id}\\dir\\')
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

		# form 2

		assert_false path_is_rooted?('\\\\server\\share')
		assert path_is_rooted?('\\\\server\\share\\')
		assert path_is_rooted?('\\\\server\\share/')

		assert_false path_is_rooted?('\\\\server\\the-share_name')
		assert path_is_rooted?('\\\\server\\the-share_name/')
		assert path_is_rooted?('\\\\server\\the-share_name\\')
		assert path_is_rooted?('\\\\server\\the-share_name\\\\')
		assert path_is_rooted?('\\\\server\\the-share_name\\dir')
		assert path_is_rooted?('\\\\server\\the-share_name\\dir\\')

		assert_false path_is_rooted?('\\\\101.2.303.4\\the-share_name')
		assert path_is_rooted?('\\\\101.2.303.4\\the-share_name/')
		assert path_is_rooted?('\\\\101.2.303.4\\the-share_name\\')
		assert path_is_rooted?('\\\\101.2.303.4\\the-share_name\\\\')
		assert path_is_rooted?('\\\\101.2.303.4\\the-share_name\\dir')
		assert path_is_rooted?('\\\\101.2.303.4\\the-share_name\\dir\\')

		assert_false path_is_rooted?('\\\\::1/128\\the-share_name')
		assert path_is_rooted?('\\\\::1/128\\the-share_name/')
		assert path_is_rooted?('\\\\::1/128\\the-share_name\\')
		assert path_is_rooted?('\\\\::1/128\\the-share_name\\\\')
		assert path_is_rooted?('\\\\::1/128\\the-share_name\\dir')
		assert path_is_rooted?('\\\\::1/128\\the-share_name\\dir\\')

		# form 4

		assert_false path_is_rooted?('\\\\?\\server\\the-share_name')
		assert path_is_rooted?('\\\\?\\server\\the-share_name/')
		assert path_is_rooted?('\\\\?\\server\\the-share_name\\')
		assert path_is_rooted?('\\\\?\\server\\the-share_name\\\\')
		assert path_is_rooted?('\\\\?\\server\\the-share_name\\dir')
		assert path_is_rooted?('\\\\?\\server\\the-share_name\\dir\\')

		assert_false path_is_rooted?('\\\\?\\101.2.303.4\\the-share_name')
		assert path_is_rooted?('\\\\?\\101.2.303.4\\the-share_name/')
		assert path_is_rooted?('\\\\?\\101.2.303.4\\the-share_name\\')
		assert path_is_rooted?('\\\\?\\101.2.303.4\\the-share_name\\\\')
		assert path_is_rooted?('\\\\?\\101.2.303.4\\the-share_name\\dir')
		assert path_is_rooted?('\\\\?\\101.2.303.4\\the-share_name\\dir\\')

		assert_false path_is_rooted?('\\\\?\\::1/128\\the-share_name')
		assert path_is_rooted?('\\\\?\\::1/128\\the-share_name/')
		assert path_is_rooted?('\\\\?\\::1/128\\the-share_name\\')
		assert path_is_rooted?('\\\\?\\::1/128\\the-share_name\\\\')
		assert path_is_rooted?('\\\\?\\::1/128\\the-share_name\\dir')
		assert path_is_rooted?('\\\\?\\::1/128\\the-share_name\\dir\\')

		# form 5

		assert_false path_is_rooted?('\\\\?\\UNC\\server\\the-share_name')
		assert path_is_rooted?('\\\\?\\UNC\\server\\the-share_name/')
		assert path_is_rooted?('\\\\?\\UNC\\server\\the-share_name\\')
		assert path_is_rooted?('\\\\?\\UNC\\server\\the-share_name\\\\')
		assert path_is_rooted?('\\\\?\\UNC\\server\\the-share_name\\dir')
		assert path_is_rooted?('\\\\?\\UNC\\server\\the-share_name\\dir\\')

		assert_false path_is_rooted?('\\\\?\\UNC\\101.2.303.4\\the-share_name')
		assert path_is_rooted?('\\\\?\\UNC\\101.2.303.4\\the-share_name/')
		assert path_is_rooted?('\\\\?\\UNC\\101.2.303.4\\the-share_name\\')
		assert path_is_rooted?('\\\\?\\UNC\\101.2.303.4\\the-share_name\\\\')
		assert path_is_rooted?('\\\\?\\UNC\\101.2.303.4\\the-share_name\\dir')
		assert path_is_rooted?('\\\\?\\UNC\\101.2.303.4\\the-share_name\\dir\\')

		assert_false path_is_rooted?('\\\\?\\UNC\\::1/128\\the-share_name')
		assert path_is_rooted?('\\\\?\\UNC\\::1/128\\the-share_name/')
		assert path_is_rooted?('\\\\?\\UNC\\::1/128\\the-share_name\\')
		assert path_is_rooted?('\\\\?\\UNC\\::1/128\\the-share_name\\\\')
		assert path_is_rooted?('\\\\?\\UNC\\::1/128\\the-share_name\\dir')
		assert path_is_rooted?('\\\\?\\UNC\\::1/128\\the-share_name\\dir\\')
	end

	def test_absolute_paths_from_drive

		# form 1

		assert path_is_rooted?('C:\\')
		assert path_is_rooted?('C:\\abc')
		assert path_is_rooted?('C:\\abc\\')

		assert_false path_is_rooted?('C:')
		assert_false path_is_rooted?('C:abc')
		assert_false path_is_rooted?('C:abc\\')

		# form 3

		assert path_is_rooted?('\\\\?\\C:\\')
		assert path_is_rooted?('\\\\?\\C:\\abc')
		assert path_is_rooted?('\\\\?\\C:\\abc\\')

		assert_false path_is_rooted?('\\\\?\\C:')
		assert_false path_is_rooted?('\\\\?\\C:abc')
		assert_false path_is_rooted?('\\\\?\\C:abc\\')
	end

	def test_absolute_paths_from_device

		# form 6

		assert_false path_is_rooted?('\\\\.\\')
		assert_false path_is_rooted?('\\\\.\\{device-id}')
		assert_false path_is_rooted?('\\\\.\\{device-id}/')
		assert path_is_rooted?('\\\\.\\{device-id}\\')
		assert path_is_rooted?('\\\\.\\{device-id}\\\\')
		assert path_is_rooted?('\\\\.\\{device-id}\\dir')
		assert path_is_rooted?('\\\\.\\{device-id}\\dir\\')
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

		# form 3

		assert_false path_is_UNC?('\\\\?\\C')
		assert path_is_UNC?('\\\\?\\C:')
		assert path_is_UNC?('\\\\?\\C:\\')
		assert path_is_UNC?('\\\\?\\C:\\\\')
		assert path_is_UNC?('\\\\?\\C:\\abc\\')
		assert path_is_UNC?('\\\\?\\C:\\abc/')

		# form 2

		assert_false path_is_UNC?('\\\\server')
		assert_false path_is_UNC?('\\\\server\\')

		assert path_is_UNC?('\\\\server\\share')

		assert path_is_UNC?('\\\\server\\the-share_name')
		assert path_is_UNC?('\\\\server\\the-share_name/')
		assert path_is_UNC?('\\\\server\\the-share_name\\')
		assert path_is_UNC?('\\\\server\\the-share_name\\\\')
		assert path_is_UNC?('\\\\server\\the-share_name\\dir')
		assert path_is_UNC?('\\\\server\\the-share_name\\dir\\')

		assert path_is_UNC?('\\\\101.2.303.4\\the-share_name')
		assert path_is_UNC?('\\\\101.2.303.4\\the-share_name/')
		assert path_is_UNC?('\\\\101.2.303.4\\the-share_name\\')
		assert path_is_UNC?('\\\\101.2.303.4\\the-share_name\\\\')
		assert path_is_UNC?('\\\\101.2.303.4\\the-share_name\\dir')
		assert path_is_UNC?('\\\\101.2.303.4\\the-share_name\\dir\\')

		assert path_is_UNC?('\\\\::1/128\\the-share_name')
		assert path_is_UNC?('\\\\::1/128\\the-share_name/')
		assert path_is_UNC?('\\\\::1/128\\the-share_name\\')
		assert path_is_UNC?('\\\\::1/128\\the-share_name\\\\')
		assert path_is_UNC?('\\\\::1/128\\the-share_name\\dir')
		assert path_is_UNC?('\\\\::1/128\\the-share_name\\dir\\')

		# form 4

		assert_false path_is_UNC?('\\\\?\\server')
		assert_false path_is_UNC?('\\\\?\\server\\')

		assert path_is_UNC?('\\\\?\\server\\share')

		assert path_is_UNC?('\\\\?\\server\\the-share_name')
		assert path_is_UNC?('\\\\?\\server\\the-share_name/')
		assert path_is_UNC?('\\\\?\\server\\the-share_name\\')
		assert path_is_UNC?('\\\\?\\server\\the-share_name\\\\')
		assert path_is_UNC?('\\\\?\\server\\the-share_name\\dir')
		assert path_is_UNC?('\\\\?\\server\\the-share_name\\dir\\')

		assert path_is_UNC?('\\\\?\\101.2.303.4\\the-share_name')
		assert path_is_UNC?('\\\\?\\101.2.303.4\\the-share_name/')
		assert path_is_UNC?('\\\\?\\101.2.303.4\\the-share_name\\')
		assert path_is_UNC?('\\\\?\\101.2.303.4\\the-share_name\\\\')
		assert path_is_UNC?('\\\\?\\101.2.303.4\\the-share_name\\dir')
		assert path_is_UNC?('\\\\?\\101.2.303.4\\the-share_name\\dir\\')

		assert path_is_UNC?('\\\\?\\::1/128\\the-share_name')
		assert path_is_UNC?('\\\\?\\::1/128\\the-share_name/')
		assert path_is_UNC?('\\\\?\\::1/128\\the-share_name\\')
		assert path_is_UNC?('\\\\?\\::1/128\\the-share_name\\\\')
		assert path_is_UNC?('\\\\?\\::1/128\\the-share_name\\dir')
		assert path_is_UNC?('\\\\?\\::1/128\\the-share_name\\dir\\')

		# form 5

		assert_false path_is_UNC?('\\\\?\\UNC\\server')
		assert_false path_is_UNC?('\\\\?\\UNC\\server\\')

		assert path_is_UNC?('\\\\?\\UNC\\server\\share')

		assert path_is_UNC?('\\\\?\\UNC\\server\\the-share_name')
		assert path_is_UNC?('\\\\?\\UNC\\server\\the-share_name/')
		assert path_is_UNC?('\\\\?\\UNC\\server\\the-share_name\\')
		assert path_is_UNC?('\\\\?\\UNC\\server\\the-share_name\\\\')
		assert path_is_UNC?('\\\\?\\UNC\\server\\the-share_name\\dir')
		assert path_is_UNC?('\\\\?\\UNC\\server\\the-share_name\\dir\\')

		assert path_is_UNC?('\\\\?\\UNC\\101.2.303.4\\the-share_name')
		assert path_is_UNC?('\\\\?\\UNC\\101.2.303.4\\the-share_name/')
		assert path_is_UNC?('\\\\?\\UNC\\101.2.303.4\\the-share_name\\')
		assert path_is_UNC?('\\\\?\\UNC\\101.2.303.4\\the-share_name\\\\')
		assert path_is_UNC?('\\\\?\\UNC\\101.2.303.4\\the-share_name\\dir')
		assert path_is_UNC?('\\\\?\\UNC\\101.2.303.4\\the-share_name\\dir\\')

		assert path_is_UNC?('\\\\?\\UNC\\::1/128\\the-share_name')
		assert path_is_UNC?('\\\\?\\UNC\\::1/128\\the-share_name/')
		assert path_is_UNC?('\\\\?\\UNC\\::1/128\\the-share_name\\')
		assert path_is_UNC?('\\\\?\\UNC\\::1/128\\the-share_name\\\\')
		assert path_is_UNC?('\\\\?\\UNC\\::1/128\\the-share_name\\dir')
		assert path_is_UNC?('\\\\?\\UNC\\::1/128\\the-share_name\\dir\\')

		# form 6

		assert_false path_is_UNC?('\\\\.\\')

		assert path_is_UNC?('\\\\.\\{device-id}\\')
		assert path_is_UNC?('\\\\.\\{device-id}\\\\')
		assert path_is_UNC?('\\\\.\\{device-id}\\dir')
		assert path_is_UNC?('\\\\.\\{device-id}\\dir\\')
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

class Test_path_is_letter_drived_Windows < Test::Unit::TestCase

	include ::LibPath::Form::Windows

	if $DEBUG

		def test_with_nil

			assert_raise(::ArgumentError) { path_is_letter_drived?(nil) }
		end
	end

	def test_empty

		assert_nil path_is_letter_drived?('')
	end

	def test_absolute_paths_from_drive

		assert_equal 2, path_is_letter_drived?('C:')
		assert_equal 3, path_is_letter_drived?('C:\\')
		assert_equal 3, path_is_letter_drived?('C:/')
		assert_equal 3, path_is_letter_drived?('C:\\\\')
		assert_equal 3, path_is_letter_drived?('C:\\abc\\')

		assert_equal 6, path_is_letter_drived?('\\\\?\\C:')
		assert_equal 7, path_is_letter_drived?('\\\\?\\C:\\')
		assert_equal 7, path_is_letter_drived?('\\\\?\\C:/')
		assert_equal 7, path_is_letter_drived?('\\\\?\\C:\\\\')
		assert_equal 7, path_is_letter_drived?('\\\\?\\C:\\abc\\')
	end

	def test_absolute_paths_from_other_UNC

		assert_nil path_is_letter_drived?('\\\\')
		assert_nil path_is_letter_drived?('\\\\server')
		assert_nil path_is_letter_drived?('\\\\server\\')
		assert_nil path_is_letter_drived?('\\\\server\\share')

		assert_nil path_is_letter_drived?('\\\\server\\the-share_name\\')
		assert_nil path_is_letter_drived?('\\\\server\\the-share_name\\\\')
		assert_nil path_is_letter_drived?('\\\\server\\the-share_name\\dir')
		assert_nil path_is_letter_drived?('\\\\server\\the-share_name\\dir\\')

		assert_nil path_is_letter_drived?('\\\\101.2.303.4\\the-share_name\\')
		assert_nil path_is_letter_drived?('\\\\101.2.303.4\\the-share_name\\\\')
		assert_nil path_is_letter_drived?('\\\\101.2.303.4\\the-share_name\\dir')
		assert_nil path_is_letter_drived?('\\\\101.2.303.4\\the-share_name\\dir\\')

		assert_nil path_is_letter_drived?('\\\\::1/128\\the-share_name\\')
		assert_nil path_is_letter_drived?('\\\\::1/128\\the-share_name\\\\')
		assert_nil path_is_letter_drived?('\\\\::1/128\\the-share_name\\dir')
		assert_nil path_is_letter_drived?('\\\\::1/128\\the-share_name\\dir\\')
	end

	def test_absolute_paths_from_root

		assert_nil path_is_letter_drived?('\\')
		assert_nil path_is_letter_drived?('\\\\')
		assert_nil path_is_letter_drived?('\\abc')

		assert_nil path_is_letter_drived?('/')
		assert_nil path_is_letter_drived?('//')
		assert_nil path_is_letter_drived?('/abc')
	end

	def test_absolute_paths_from_home

		assert_nil path_is_letter_drived?('~')
		assert_nil path_is_letter_drived?('~/')
		assert_nil path_is_letter_drived?('~/abc')
	end

	def test_relative_paths

		assert_nil path_is_letter_drived?('abc')
		assert_nil path_is_letter_drived?('abc/')
		assert_nil path_is_letter_drived?('a/')

		assert_nil path_is_letter_drived?('~abc')
	end
end


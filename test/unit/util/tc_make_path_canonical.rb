#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 3), 'lib')

require 'libpath/util'

require 'test/unit'

require 'libpath/internal_/platform'

class Test_LibPath_Util_make_path_canonical_via_extend < Test::Unit::TestCase

	F = ::LibPath::Util

	def test_empty

		assert_equal '', F.make_path_canonical('')
	end

	def test_root

		assert_equal '/', F.make_path_canonical('/')

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			assert_equal '\\', F.make_path_canonical('//')
		else

			assert_equal '/', F.make_path_canonical('//')
		end
	end

	def test_one_dot

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			assert_equal '.\\', F.make_path_canonical('.')

			assert_equal '.\\', F.make_path_canonical('.\\')
			assert_equal '.\\', F.make_path_canonical('.\\', make_slashes_canonical: true)

			assert_equal './', F.make_path_canonical('./')
			assert_equal '.\\', F.make_path_canonical('.\\', make_slashes_canonical: true)
		else

			assert_equal './', F.make_path_canonical('.')

			assert_equal './', F.make_path_canonical('./')
			assert_equal './', F.make_path_canonical('./', make_slashes_canonical: true)
		end
	end

	def test_two_dots

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			assert_equal '..\\', F.make_path_canonical('..')
			assert_equal '..\\', F.make_path_canonical('..//')
			assert_equal '../', F.make_path_canonical('../')

			assert_equal '/dir.14/', F.make_path_canonical('/dir.14/dir.2/..')
			assert_equal 'dir.14/', F.make_path_canonical('dir.14/dir.2/..')

			assert_equal '/', F.make_path_canonical('/dir.14/dir.2/../..')
			assert_equal '/', F.make_path_canonical('/dir.14/dir.2/../../..')
			assert_equal '.\\', F.make_path_canonical('dir.14/dir.2/../..')

			assert_equal '\\', F.make_path_canonical('\\dir.14\\dir.2\\..\\..')
			assert_equal '\\', F.make_path_canonical('\\dir.14\\dir.2\\..\\..\\..')
			assert_equal '.\\', F.make_path_canonical('dir.14\\dir.2\\..\\..')
		else

			assert_equal '../', F.make_path_canonical('..')
			assert_equal '../', F.make_path_canonical('../')

			assert_equal '/dir.14/', F.make_path_canonical('/dir.14/dir.2/..')
			assert_equal 'dir.14/', F.make_path_canonical('dir.14/dir.2/..')

			assert_equal '/', F.make_path_canonical('/dir.14/dir.2/../..')
			assert_equal '/', F.make_path_canonical('/dir.14/dir.2/../../..')
			assert_equal './', F.make_path_canonical('dir.14/dir.2/../..')
		end

	end

	def test_redundant_slashes

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			assert_equal '.\\', F.make_path_canonical('.//')
			assert_equal '.\\', F.make_path_canonical('.\\\\')

			assert_equal '..\\', F.make_path_canonical('..//')
		else

			assert_equal './', F.make_path_canonical('.//')

			assert_equal '../', F.make_path_canonical('..//')
		end
	end

	def test_basenames

		assert_equal 'a', F.make_path_canonical('a')

		assert_equal 'file.ext', F.make_path_canonical('file.ext')
	end

	def test_trailing_dots

		assert_equal 'a.', F.make_path_canonical('a.')
		assert_equal 'a.', F.make_path_canonical('./a.')
		assert_equal 'a.', F.make_path_canonical('././././a.')
		assert_equal 'a.', F.make_path_canonical('abc/../a.')

		assert_equal 'a..', F.make_path_canonical('a..')
		assert_equal 'a..', F.make_path_canonical('./a..')
		assert_equal 'a..', F.make_path_canonical('././././a..')
		assert_equal 'a..', F.make_path_canonical('abc/../a..')
		assert_equal 'a..', F.make_path_canonical('abc//../a..')

		assert_equal 'a...', F.make_path_canonical('a...')
		assert_equal 'a...', F.make_path_canonical('./a...')
		assert_equal 'a...', F.make_path_canonical('././././a...')
		assert_equal 'a...', F.make_path_canonical('abc/../a...')

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			assert_equal 'a.', F.make_path_canonical('a.')
			assert_equal 'a.', F.make_path_canonical('.\\a.')
			assert_equal 'a.', F.make_path_canonical('.\\.\\.\\.\\a.')
			assert_equal 'a.', F.make_path_canonical('abc\\..\\a.')

			assert_equal 'a..', F.make_path_canonical('a..')
			assert_equal 'a..', F.make_path_canonical('.\\a..')
			assert_equal 'a..', F.make_path_canonical('.\\.\\.\\.\\a..')
			assert_equal 'a..', F.make_path_canonical('abc\\..\\a..')

			assert_equal 'a...', F.make_path_canonical('a...')
			assert_equal 'a...', F.make_path_canonical('.\\a...')
			assert_equal 'a...', F.make_path_canonical('.\\.\\.\\.\\a...')
			assert_equal 'a...', F.make_path_canonical('abc\\..\\a...')
		end
	end

	def test_one_dots_directory

		assert_equal 'abc', F.make_path_canonical('./abc')

		assert_equal 'abc', F.make_path_canonical('././abc')
		assert_equal 'abc', F.make_path_canonical('././/abc')
		assert_equal 'abc', F.make_path_canonical('././//////////////////abc')

		assert_equal 'abc', F.make_path_canonical('./././././././././abc')

		assert_equal 'abc/', F.make_path_canonical('abc/./')

		assert_equal 'abc/', F.make_path_canonical('./abc/./')

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			assert_equal 'abc', F.make_path_canonical('.\\abc')

			assert_equal 'abc', F.make_path_canonical('.\\.\\abc')

			assert_equal 'abc', F.make_path_canonical('.\\.\\.\\.\\.\\.\\.\\.\\.\\abc')

			assert_equal 'abc\\', F.make_path_canonical('abc/./', make_slashes_canonical: true)

			assert_equal 'abc\\', F.make_path_canonical('abc\\.\\')

			assert_equal 'abc\\', F.make_path_canonical('.\\abc\\.\\')

			assert_equal 'abc\\', F.make_path_canonical('./abc/./', make_slashes_canonical: true)
		end
	end

	def test_two_dots_directories

		assert_equal '../', F.make_path_canonical('../')

		assert_equal '../abc', F.make_path_canonical('../abc')

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			assert_equal '.\\', F.make_path_canonical('abc/..')
		else

			assert_equal './', F.make_path_canonical('abc/..')
		end

		assert_equal './', F.make_path_canonical('abc/../')

		assert_equal 'def', F.make_path_canonical('abc/../def')

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			assert_equal '.\\', F.make_path_canonical('abc/../def/..')
		else

			assert_equal './', F.make_path_canonical('abc/../def/..')
		end

		assert_equal './', F.make_path_canonical('abc/../def/../')

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			assert_equal '..\\', F.make_path_canonical('..\\')

			assert_equal '..\\abc', F.make_path_canonical('..\\abc')

			assert_equal '.\\', F.make_path_canonical('abc\\..')

			assert_equal '.\\', F.make_path_canonical('abc\\..\\')

			assert_equal 'def', F.make_path_canonical('abc\\..\\def')
			assert_equal 'def', F.make_path_canonical('abc\\\\..\\def')

			assert_equal '.\\', F.make_path_canonical('abc\\..\\def\\..')

			assert_equal '.\\', F.make_path_canonical('abc\\..\\def\\..\\')
			assert_equal '.\\', F.make_path_canonical('abc\\\\..\\def\\..\\')
			assert_equal '.\\', F.make_path_canonical('abc\\..\\\\def\\..\\')
		end
	end
end



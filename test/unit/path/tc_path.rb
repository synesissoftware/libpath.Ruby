#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 3), 'lib')

require 'libpath/path'

require 'test/unit'

require 'xqsr3/extensions/test/unit'

require 'libpath/internal_/platform'

class Test_existence_of_namespace_LibPath_Path < Test::Unit::TestCase

	def test_LibPath_module_exists

		assert defined?(::LibPath)
	end

	def test_LibPath_Path_module_exists

		assert defined?(::LibPath::Path)
	end

	def test_LibPath_Path_ParsedPath_class_exists

		assert defined?(::LibPath::Path::ParsedPath)
	end
end

class Test_LibPath_Path_ParsedPath < Test::Unit::TestCase

	include ::LibPath::Path

	def test_nil

		assert_raise(::ArgumentError) { ParsedPath.new(nil) }
	end

	def test_empty

		assert_raise(::ArgumentError) { ParsedPath.new('') }
	end

	def test_root

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			pp	=	ParsedPath.new('C:\\')

			assert_equal 'C:\\', pp.given_path
			assert_equal 'C:\\', pp.absolute_path
			assert_equal 'C:\\', pp.compare_path
			assert_equal 'C:', pp.volume
			assert_equal '\\', pp.directory
			assert_equal 'C:\\', pp.directory_path
			assert_equal 'C:\\', pp.dirname
			assert_equal [ '\\' ], pp.directory_parts

			volume = pp.volume
		else

			pp	=	ParsedPath.new('/')

			assert_equal '/', pp.given_path
			assert_equal '/', pp.absolute_path
			assert_equal '/', pp.compare_path
			assert_equal '/', pp.directory
			assert_equal '/', pp.directory_path
			assert_equal '/', pp.dirname
			assert_equal [ '/' ], pp.directory_parts

			volume = nil
		end
		assert_nil pp.file_full_name
		assert_nil pp.basename
		assert_nil pp.file_name_only
		assert_nil pp.stem
		assert_nil pp.file_extension
		assert_nil pp.extension
		assert_nil pp.search_directory
		assert_nil pp.search_relative_path
		assert_nil pp.search_relative_directory_path
		assert_nil pp.search_relative_directory_parts

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end

	def test_root_from_srd_1

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			srd	=	'C:/dir-1/dir-2'

			pp	=	ParsedPath.new('C:\\', srd)

			assert_equal 'C:\\', pp.given_path
			assert_equal 'C:\\', pp.absolute_path
			assert_equal 'C:\\', pp.compare_path
			assert_equal 'C:', pp.volume
			assert_equal '\\', pp.directory
			assert_equal 'C:\\', pp.directory_path
			assert_equal 'C:\\', pp.dirname
			assert_equal [ '\\' ], pp.directory_parts

			volume = pp.volume
		else

			srd	=	'/dir-1/dir-2'

			pp	=	ParsedPath.new('/', srd)

			assert_equal '/', pp.given_path
			assert_equal '/', pp.absolute_path
			assert_equal '/', pp.compare_path
			assert_equal '/', pp.directory
			assert_equal '/', pp.directory_path
			assert_equal '/', pp.dirname
			assert_equal [ '/' ], pp.directory_parts

			volume = nil
		end
		assert_nil pp.file_full_name
		assert_nil pp.basename
		assert_nil pp.file_name_only
		assert_nil pp.stem
		assert_nil pp.file_extension
		assert_nil pp.extension

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			assert_equal 'C:\\dir-1\\dir-2\\', pp.search_directory
			assert_equal '..\\..\\', pp.search_relative_path
			assert_equal '..\\..\\', pp.search_relative_directory_path
			assert_equal [ '..\\', '..\\' ], pp.search_relative_directory_parts
		else

			assert_equal '/dir-1/dir-2/', pp.search_directory
			assert_equal '../../', pp.search_relative_path
			assert_equal '../../', pp.search_relative_directory_path
			assert_equal [ '../', '../' ], pp.search_relative_directory_parts
		end

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end

	def test_root_from_srd_2

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			srd	=	'C:/'

			pp	=	ParsedPath.new('C:\\', srd)

			assert_equal 'C:\\', pp.given_path
			assert_equal 'C:\\', pp.absolute_path
			assert_equal 'C:\\', pp.compare_path
			assert_equal 'C:', pp.volume
			assert_equal '\\', pp.directory
			assert_equal 'C:\\', pp.directory_path
			assert_equal 'C:\\', pp.dirname
			assert_equal [ '\\' ], pp.directory_parts

			volume = pp.volume
		else

			srd	=	'/'

			pp	=	ParsedPath.new('/', srd)

			assert_equal '/', pp.given_path
			assert_equal '/', pp.absolute_path
			assert_equal '/', pp.compare_path
			assert_equal '/', pp.directory
			assert_equal '/', pp.directory_path
			assert_equal '/', pp.dirname
			assert_equal [ '/' ], pp.directory_parts

			volume = nil
		end
		assert_nil pp.file_full_name
		assert_nil pp.basename
		assert_nil pp.file_name_only
		assert_nil pp.stem
		assert_nil pp.file_extension
		assert_nil pp.extension

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			assert_equal 'C:\\', pp.search_directory
			assert_equal '.\\', pp.search_relative_path
			assert_equal '.\\', pp.search_relative_directory_path
			assert_equal [ '.\\' ], pp.search_relative_directory_parts
		else

			assert_equal '/', pp.search_directory
			assert_equal './', pp.search_relative_path
			assert_equal './', pp.search_relative_directory_path
			assert_equal [ './' ], pp.search_relative_directory_parts
		end

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end

	def test_rooted_one_dir

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			pp	=	ParsedPath.new('G:\\abc\\')

			assert_equal 'G:\\abc\\', pp.given_path
			assert_equal 'G:\\abc\\', pp.absolute_path
			assert_equal 'G:\\abc\\', pp.compare_path
			assert_equal '\\abc\\', pp.directory
			assert_equal 'G:', pp.volume
			assert_equal 'G:\\abc\\', pp.directory_path
			assert_equal 'G:\\abc\\', pp.dirname
			assert_equal [ '\\', 'abc\\' ], pp.directory_parts

			volume = pp.volume
		else

			pp	=	ParsedPath.new('/abc//')

			assert_equal '/abc//', pp.given_path
			assert_equal '/abc/', pp.absolute_path
			assert_equal '/abc/', pp.compare_path
			assert_equal '/abc/', pp.directory
			assert_equal '/abc/', pp.directory_path
			assert_equal '/abc/', pp.dirname
			assert_equal [ '/', 'abc/' ], pp.directory_parts

			volume = nil
		end
		assert_nil pp.file_full_name
		assert_nil pp.basename
		assert_nil pp.file_name_only
		assert_nil pp.stem
		assert_nil pp.file_extension
		assert_nil pp.extension
		assert_nil pp.search_directory
		assert_nil pp.search_relative_path
		assert_nil pp.search_relative_directory_path
		assert_nil pp.search_relative_directory_parts

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end

	def test_rooted_one_dir_from_srd

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			srd	=	'G:/dir-1/dir-2'

			pp	=	ParsedPath.new('G:\\\\abc\\\\', srd)

			assert_equal 'G:\\\\abc\\\\', pp.given_path
			assert_equal 'G:\\abc\\', pp.absolute_path
			assert_equal 'G:\\abc\\', pp.compare_path
			assert_equal '\\abc\\', pp.directory
			assert_equal 'G:', pp.volume
			assert_equal 'G:\\abc\\', pp.directory_path
			assert_equal 'G:\\abc\\', pp.dirname
			assert_equal [ '\\', 'abc\\' ], pp.directory_parts

			volume = pp.volume
		else

			srd	=	'/dir-1/dir-2'

			pp	=	ParsedPath.new('//abc//', srd)

			assert_equal '//abc//', pp.given_path
			assert_equal '/abc/', pp.absolute_path
			assert_equal '/abc/', pp.compare_path
			assert_equal '/abc/', pp.directory
			assert_equal '/abc/', pp.directory_path
			assert_equal '/abc/', pp.dirname
			assert_equal [ '/', 'abc/' ], pp.directory_parts

			volume = nil
		end
		assert_nil pp.file_full_name
		assert_nil pp.basename
		assert_nil pp.file_name_only
		assert_nil pp.stem
		assert_nil pp.file_extension
		assert_nil pp.extension

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			assert_equal 'G:\\dir-1\\dir-2\\', pp.search_directory
			assert_equal '..\\..\\abc\\', pp.search_relative_path
			assert_equal '..\\..\\abc\\', pp.search_relative_directory_path
			assert_equal [ '..\\', '..\\', 'abc\\' ], pp.search_relative_directory_parts
		else

		end

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end

	def test_rooted_one_dir_with_trailing_dot

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			pp	=	ParsedPath.new('G:\\abc\\.')

			assert_equal 'G:\\abc\\.', pp.given_path
			assert_equal 'G:\\abc\\', pp.absolute_path
			assert_equal 'G:\\abc\\', pp.compare_path
			assert_equal 'G:', pp.volume
			assert_equal '\\abc\\', pp.directory
			assert_equal 'G:\\abc\\', pp.directory_path
			assert_equal 'G:\\abc\\', pp.dirname
			assert_equal [ '\\', 'abc\\' ], pp.directory_parts

			volume = pp.volume
		else

			pp	=	ParsedPath.new('/abc/.')

			assert_equal '/abc/.', pp.given_path
			assert_equal '/abc/', pp.absolute_path
			assert_equal '/abc/', pp.compare_path
			assert_equal '/abc/', pp.directory
			assert_equal '/abc/', pp.directory_path
			assert_equal '/abc/', pp.dirname
			assert_equal [ '/', 'abc/' ], pp.directory_parts

			volume = nil
		end
		assert_nil pp.file_full_name
		assert_nil pp.basename
		assert_nil pp.file_name_only
		assert_nil pp.stem
		assert_nil pp.file_extension
		assert_nil pp.extension
		assert_nil pp.search_directory
		assert_nil pp.search_relative_path
		assert_nil pp.search_relative_directory_path
		assert_nil pp.search_relative_directory_parts

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end

	def test_rooted_one_file

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			pp	=	ParsedPath.new('G:\\file.ext')

			assert_equal 'G:\\file.ext', pp.given_path
			assert_equal 'G:\\file.ext', pp.absolute_path
			assert_equal 'G:\\file.ext', pp.compare_path
			assert_equal 'G:', pp.volume
			assert_equal '\\', pp.directory
			assert_equal 'G:\\', pp.directory_path
			assert_equal 'G:\\', pp.dirname
			assert_equal [ '\\' ], pp.directory_parts

			volume = pp.volume
		else

			pp	=	ParsedPath.new('/file.ext')

			assert_equal '/file.ext', pp.given_path
			assert_equal '/file.ext', pp.absolute_path
			assert_equal '/file.ext', pp.compare_path
			assert_equal '/', pp.directory
			assert_equal '/', pp.directory_path
			assert_equal '/', pp.dirname
			assert_equal [ '/' ], pp.directory_parts

			volume = nil
		end
		assert_equal 'file.ext', pp.file_full_name
		assert_equal 'file.ext', pp.basename
		assert_equal 'file', pp.file_name_only
		assert_equal 'file', pp.stem
		assert_equal '.ext', pp.file_extension
		assert_equal '.ext', pp.extension
		assert_nil pp.search_directory
		assert_nil pp.search_relative_path
		assert_nil pp.search_relative_directory_path
		assert_nil pp.search_relative_directory_parts

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end

	def test_rooted_one_file_without_extension

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			pp	=	ParsedPath.new('G:\\file')

			assert_equal 'G:\\file', pp.given_path
			assert_equal 'G:\\file', pp.absolute_path
			assert_equal 'G:\\file', pp.compare_path
			assert_equal 'G:', pp.volume
			assert_equal '\\', pp.directory
			assert_equal 'G:\\', pp.directory_path
			assert_equal 'G:\\', pp.dirname
			assert_equal [ '\\' ], pp.directory_parts

			volume = pp.volume
		else

			pp	=	ParsedPath.new('/file')

			assert_equal '/file', pp.given_path
			assert_equal '/file', pp.absolute_path
			assert_equal '/file', pp.compare_path
			assert_equal '/', pp.directory
			assert_equal '/', pp.directory_path
			assert_equal '/', pp.dirname
			assert_equal [ '/' ], pp.directory_parts

			volume = nil
		end
		assert_equal 'file', pp.file_full_name
		assert_equal 'file', pp.basename
		assert_equal 'file', pp.file_name_only
		assert_equal 'file', pp.stem
		assert_nil pp.file_extension
		assert_nil pp.extension
		assert_nil pp.search_directory
		assert_nil pp.search_relative_path
		assert_nil pp.search_relative_directory_path
		assert_nil pp.search_relative_directory_parts

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end

	def test_rooted_one_file_without_stem

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			pp	=	ParsedPath.new('H:\\.ext')

			assert_equal 'H:\\.ext', pp.given_path
			assert_equal 'H:\\.ext', pp.absolute_path
			assert_equal 'H:\\.ext', pp.compare_path
			assert_equal 'H:', pp.volume
			assert_equal '\\', pp.directory
			assert_equal 'H:\\', pp.directory_path
			assert_equal 'H:\\', pp.dirname
			assert_equal [ '\\' ], pp.directory_parts

			volume = pp.volume
		else

			pp	=	ParsedPath.new('/.ext')

			assert_equal '/.ext', pp.given_path
			assert_equal '/.ext', pp.absolute_path
			assert_equal '/.ext', pp.compare_path
			assert_equal '/', pp.directory
			assert_equal '/', pp.directory_path
			assert_equal '/', pp.dirname
			assert_equal [ '/' ], pp.directory_parts

			volume = nil
		end
		assert_equal '.ext', pp.file_full_name
		assert_equal '.ext', pp.basename
		assert_nil pp.file_name_only
		assert_nil pp.stem
		assert_equal '.ext', pp.file_extension
		assert_equal '.ext', pp.extension
		assert_nil pp.search_directory
		assert_nil pp.search_relative_path
		assert_nil pp.search_relative_directory_path
		assert_nil pp.search_relative_directory_parts

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end

	def test_rooted_one_long_path

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			pp	=	ParsedPath.new('C:/dir-1/dir-2/dir-3/dir-4/./dir-5/dir-6/../file.ext')

			assert_equal 'C:/dir-1/dir-2/dir-3/dir-4/./dir-5/dir-6/../file.ext', pp.given_path
			assert_equal 'C:/dir-1/dir-2/dir-3/dir-4/dir-5/file.ext', pp.absolute_path
			assert_equal 'C:/dir-1/dir-2/dir-3/dir-4/dir-5/file.ext', pp.compare_path
			assert_equal 'C:', pp.volume
			assert_equal '/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.directory
			assert_equal 'C:/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.directory_path
			assert_equal 'C:/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.dirname
			assert_equal [ '/', 'dir-1/', 'dir-2/', 'dir-3/', 'dir-4/', 'dir-5/' ], pp.directory_parts

			volume = pp.volume
		else

			pp	=	ParsedPath.new('/dir-1/dir-2/dir-3/dir-4/./dir-5/dir-6/../file.ext')

			assert_equal '/dir-1/dir-2/dir-3/dir-4/./dir-5/dir-6/../file.ext', pp.given_path
			assert_equal '/dir-1/dir-2/dir-3/dir-4/dir-5/file.ext', pp.absolute_path
			assert_equal '/dir-1/dir-2/dir-3/dir-4/dir-5/file.ext', pp.compare_path
			assert_equal '/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.directory
			assert_equal '/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.directory_path
			assert_equal '/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.dirname
			assert_equal [ '/', 'dir-1/', 'dir-2/', 'dir-3/', 'dir-4/', 'dir-5/' ], pp.directory_parts

			volume = nil
		end
		assert_equal 'file.ext', pp.file_full_name
		assert_equal 'file.ext', pp.basename
		assert_equal 'file', pp.file_name_only
		assert_equal 'file', pp.stem
		assert_equal '.ext', pp.file_extension
		assert_equal '.ext', pp.extension
		assert_nil pp.search_directory
		assert_nil pp.search_relative_path
		assert_nil pp.search_relative_directory_path
		assert_nil pp.search_relative_directory_parts

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end

	def test_rooted_one_long_path_with_short_directory_names

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			pp	=	ParsedPath.new('C:/1/2/3/4/./5/6/../file.ext')

			assert_equal 'C:/1/2/3/4/./5/6/../file.ext', pp.given_path
			assert_equal 'C:/1/2/3/4/5/file.ext', pp.absolute_path
			assert_equal 'C:/1/2/3/4/5/file.ext', pp.compare_path
			assert_equal 'C:', pp.volume
			assert_equal '/1/2/3/4/5/', pp.directory
			assert_equal 'C:/1/2/3/4/5/', pp.directory_path
			assert_equal 'C:/1/2/3/4/5/', pp.dirname
			assert_equal [ '/', '1/', '2/', '3/', '4/', '5/' ], pp.directory_parts

			volume = pp.volume
		else

			pp	=	ParsedPath.new('/1/2/3/4/./5/6/../file.ext')

			assert_equal '/1/2/3/4/./5/6/../file.ext', pp.given_path
			assert_equal '/1/2/3/4/5/file.ext', pp.absolute_path
			assert_equal '/1/2/3/4/5/file.ext', pp.compare_path
			assert_equal '/1/2/3/4/5/', pp.directory
			assert_equal '/1/2/3/4/5/', pp.directory_path
			assert_equal '/1/2/3/4/5/', pp.dirname
			assert_equal [ '/', '1/', '2/', '3/', '4/', '5/' ], pp.directory_parts

			volume = nil
		end
		assert_equal 'file.ext', pp.file_full_name
		assert_equal 'file.ext', pp.basename
		assert_equal 'file', pp.file_name_only
		assert_equal 'file', pp.stem
		assert_equal '.ext', pp.file_extension
		assert_equal '.ext', pp.extension
		assert_nil pp.search_directory
		assert_nil pp.search_relative_path
		assert_nil pp.search_relative_directory_path
		assert_nil pp.search_relative_directory_parts

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end

	def test_unrooted_one_file

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			pwd	=	'/some-directory'

			pp	=	ParsedPath.new('file.ext', pwd: pwd)

			assert_equal 'file.ext', pp.given_path
			assert_equal '/some-directory\\file.ext', pp.absolute_path
			assert_equal '/some-directory\\file.ext', pp.compare_path
			assert_nil pp.volume
			assert_equal '/some-directory\\', pp.directory
			assert_equal '/some-directory\\', pp.directory_path
			assert_equal '/some-directory\\', pp.dirname
			assert_equal [ '/', 'some-directory\\' ], pp.directory_parts

			volume = pp.volume
		else

			pwd	=	'/some-directory'

			pp	=	ParsedPath.new('file.ext', pwd: pwd)

			assert_equal 'file.ext', pp.given_path
			assert_equal '/some-directory/file.ext', pp.absolute_path
			assert_equal '/some-directory/file.ext', pp.compare_path
			assert_equal '/some-directory/', pp.directory
			assert_equal '/some-directory/', pp.directory_path
			assert_equal '/some-directory/', pp.dirname
			assert_equal [ '/', 'some-directory/' ], pp.directory_parts

			volume = nil
		end
		assert_equal 'file.ext', pp.file_full_name
		assert_equal 'file.ext', pp.basename
		assert_equal 'file', pp.file_name_only
		assert_equal 'file', pp.stem
		assert_equal '.ext', pp.file_extension
		assert_equal '.ext', pp.extension
		assert_nil pp.search_directory
		assert_nil pp.search_relative_path
		assert_nil pp.search_relative_directory_path
		assert_nil pp.search_relative_directory_parts

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end

	def test_unrooted_one_file_from_srd

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			pwd	=	'/some-directory'
			srd	=	'/dir-1/dir-2/'

			pp	=	ParsedPath.new('file.ext', pwd: pwd)

			assert_equal 'file.ext', pp.given_path
			assert_equal '/some-directory\\file.ext', pp.absolute_path
			assert_equal '/some-directory\\file.ext', pp.compare_path
			assert_nil pp.volume
			assert_equal '/some-directory\\', pp.directory
			assert_equal '/some-directory\\', pp.directory_path
			assert_equal '/some-directory\\', pp.dirname
			assert_equal [ '/', 'some-directory\\' ], pp.directory_parts

			volume = pp.volume
		else

			pwd	=	'/some-directory'
			srd	=	'/dir-1/dir-2/'

			pp	=	ParsedPath.new('file.ext', pwd: pwd)

			assert_equal 'file.ext', pp.given_path
			assert_equal '/some-directory/file.ext', pp.absolute_path
			assert_equal '/some-directory/file.ext', pp.compare_path
			assert_equal '/some-directory/', pp.directory
			assert_equal '/some-directory/', pp.directory_path
			assert_equal '/some-directory/', pp.dirname
			assert_equal [ '/', 'some-directory/' ], pp.directory_parts

			volume = nil
		end
		assert_equal 'file.ext', pp.file_full_name
		assert_equal 'file.ext', pp.basename
		assert_equal 'file', pp.file_name_only
		assert_equal 'file', pp.stem
		assert_equal '.ext', pp.file_extension
		assert_equal '.ext', pp.extension
		assert_nil pp.search_directory
		assert_nil pp.search_relative_path
		assert_nil pp.search_relative_directory_path
		assert_nil pp.search_relative_directory_parts

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end

	def test_unrooted_dir_file

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			pwd	=	'/some-directory'

			pp	=	ParsedPath.new('sub-dir/file.ext', pwd: pwd)

			assert_equal 'sub-dir/file.ext', pp.given_path
			assert_equal '/some-directory\\sub-dir/file.ext', pp.absolute_path
			assert_equal '/some-directory\\sub-dir/file.ext', pp.compare_path
			assert_nil pp.volume
			assert_equal '/some-directory\\sub-dir/', pp.directory
			assert_equal '/some-directory\\sub-dir/', pp.directory_path
			assert_equal '/some-directory\\sub-dir/', pp.dirname
			assert_equal [ '/', 'some-directory\\', 'sub-dir/' ], pp.directory_parts

			volume = pp.volume
		else

			pwd	=	'/some-directory'

			pp	=	ParsedPath.new('sub-dir/file.ext', pwd: pwd)

			assert_equal 'sub-dir/file.ext', pp.given_path
			assert_equal '/some-directory/sub-dir/file.ext', pp.absolute_path
			assert_equal '/some-directory/sub-dir/file.ext', pp.compare_path
			assert_equal '/some-directory/sub-dir/', pp.directory
			assert_equal '/some-directory/sub-dir/', pp.directory_path
			assert_equal '/some-directory/sub-dir/', pp.dirname
			assert_equal [ '/', 'some-directory/', 'sub-dir/' ], pp.directory_parts

			volume = nil
		end
		assert_equal 'file.ext', pp.file_full_name
		assert_equal 'file.ext', pp.basename
		assert_equal 'file', pp.file_name_only
		assert_equal 'file', pp.stem
		assert_equal '.ext', pp.file_extension
		assert_equal '.ext', pp.extension
		assert_nil pp.search_directory
		assert_nil pp.search_relative_path
		assert_nil pp.search_relative_directory_path
		assert_nil pp.search_relative_directory_parts

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end

	def test_unrooted_dir_file_2

		locator	=	Object.new

		if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

			locator.define_singleton_method(:pwd) { '/some-directory' }

			pp	=	ParsedPath.new('sub-dir/file.ext', locator: locator)

			assert_equal 'sub-dir/file.ext', pp.given_path
			assert_equal '/some-directory\\sub-dir/file.ext', pp.absolute_path
			assert_equal '/some-directory\\sub-dir/file.ext', pp.compare_path
			assert_nil pp.volume
			assert_equal '/some-directory\\sub-dir/', pp.directory
			assert_equal '/some-directory\\sub-dir/', pp.directory_path
			assert_equal '/some-directory\\sub-dir/', pp.dirname
			assert_equal [ '/', 'some-directory\\', 'sub-dir/' ], pp.directory_parts

			volume = pp.volume
		else

			locator.define_singleton_method(:pwd) { '/some-directory' }

			pp	=	ParsedPath.new('sub-dir/file.ext', locator: locator)

			assert_equal 'sub-dir/file.ext', pp.given_path
			assert_equal '/some-directory/sub-dir/file.ext', pp.absolute_path
			assert_equal '/some-directory/sub-dir/file.ext', pp.compare_path
			assert_equal '/some-directory/sub-dir/', pp.directory
			assert_equal '/some-directory/sub-dir/', pp.directory_path
			assert_equal '/some-directory/sub-dir/', pp.dirname
			assert_equal [ '/', 'some-directory/', 'sub-dir/' ], pp.directory_parts

			volume = nil
		end
		assert_equal 'file.ext', pp.file_full_name
		assert_equal 'file.ext', pp.basename
		assert_equal 'file', pp.file_name_only
		assert_equal 'file', pp.stem
		assert_equal '.ext', pp.file_extension
		assert_equal '.ext', pp.extension
		assert_nil pp.search_directory
		assert_nil pp.search_relative_path
		assert_nil pp.search_relative_directory_path
		assert_nil pp.search_relative_directory_parts

		assert_equal pp.directory, pp.directory_parts.join
		assert_equal pp.absolute_path, "#{volume}#{pp.directory_parts.join}#{pp.basename}"
	end
end


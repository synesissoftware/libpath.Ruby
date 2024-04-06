#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 4), 'lib')


require 'libpath/path/windows'

require 'test/unit'

require 'xqsr3/extensions/test/unit'

require 'libpath/internal_/platform'


class Test_existence_of_namespace_LibPath_Path_Windows < Test::Unit::TestCase

  def test_LibPath_module_exists

    assert defined?(::LibPath)
  end

  def test_LibPath_Path_module_exists

    assert defined?(::LibPath::Path)
  end

  def test_LibPath_Path_Windows_module_exists

    assert defined?(::LibPath::Path::Windows)
  end

  def test_LibPath_Path_Windows_ParsedPath_class_exists

    assert defined?(::LibPath::Path::Windows::ParsedPath)
  end
end

class Test_LibPath_Path_Windows_ParsedPath < Test::Unit::TestCase

  include ::LibPath::Path::Windows

  def test_nil

    assert_raise(::ArgumentError) { ParsedPath.new(nil) }
  end

  def test_empty

    assert_raise(::ArgumentError) { ParsedPath.new('') }
  end

  def test_root

    pp = ParsedPath.new('C:\\')

    assert_equal 'C:\\', pp.given_path
    assert_equal 'C:\\', pp.absolute_path
    assert_equal 'C:\\', pp.compare_path
    assert_equal 'C:', pp.volume
    assert_equal '\\', pp.directory
    assert_equal 'C:\\', pp.directory_path
    assert_equal 'C:\\', pp.dirname
    assert_equal [ '\\' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_root_lower_drive_letter

    pp = ParsedPath.new('c:\\')

    assert_equal 'c:\\', pp.given_path
    assert_equal 'c:\\', pp.absolute_path
    assert_equal 'C:\\', pp.compare_path
    assert_equal 'c:', pp.volume
    assert_equal '\\', pp.directory
    assert_equal 'c:\\', pp.directory_path
    assert_equal 'c:\\', pp.dirname
    assert_equal [ '\\' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_root_from_srd_1

    srd = 'C:/dir-1/dir-2'

    pp = ParsedPath.new('C:\\', srd)

    assert_equal 'C:\\', pp.given_path
    assert_equal 'C:\\', pp.absolute_path
    assert_equal 'C:\\', pp.compare_path
    assert_equal 'C:', pp.volume
    assert_equal '\\', pp.directory
    assert_equal 'C:\\', pp.directory_path
    assert_equal 'C:\\', pp.dirname
    assert_equal [ '\\' ], pp.directory_parts
    assert_nil pp.file_full_name
    assert_nil pp.basename
    assert_nil pp.file_name_only
    assert_nil pp.stem
    assert_nil pp.file_extension
    assert_nil pp.extension
    assert_equal 'C:\\dir-1\\dir-2\\', pp.search_directory
    assert_equal '..\\..\\', pp.search_relative_path
    assert_equal '..\\..\\', pp.search_relative_directory_path
    assert_equal [ '..\\', '..\\' ], pp.search_relative_directory_parts

    assert_equal pp.directory, pp.directory_parts.join
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_root_UNC_form2

    pp = ParsedPath.new('\\\\server\\share\\')

    assert_equal '\\\\server\\share\\', pp.given_path
    assert_equal '\\\\server\\share\\', pp.absolute_path
    assert_equal '\\\\server\\share\\', pp.compare_path
    assert_equal '\\\\server\\share', pp.volume
    assert_equal '\\', pp.directory
    assert_equal '\\\\server\\share\\', pp.directory_path
    assert_equal '\\\\server\\share\\', pp.dirname
    assert_equal [ '\\' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_root_UNC_form3

    pp = ParsedPath.new('\\\\?\\C:\\')

    assert_equal '\\\\?\\C:\\', pp.given_path
    assert_equal '\\\\?\\C:\\', pp.absolute_path
    assert_equal '\\\\?\\C:\\', pp.compare_path
    assert_equal '\\\\?\\C:', pp.volume
    assert_equal '\\', pp.directory
    assert_equal '\\\\?\\C:\\', pp.directory_path
    assert_equal '\\\\?\\C:\\', pp.dirname
    assert_equal [ '\\' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_root_UNC_form4

    pp = ParsedPath.new('\\\\?\\server\\share\\')

    assert_equal '\\\\?\\server\\share\\', pp.given_path
    assert_equal '\\\\?\\server\\share\\', pp.absolute_path
    assert_equal '\\\\?\\server\\share\\', pp.compare_path
    assert_equal '\\\\?\\server\\share', pp.volume
    assert_equal '\\', pp.directory
    assert_equal '\\\\?\\server\\share\\', pp.directory_path
    assert_equal '\\\\?\\server\\share\\', pp.dirname
    assert_equal [ '\\' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_root_UNC_form5

    pp = ParsedPath.new('\\\\?\\UNC\\server\\share\\')

    assert_equal '\\\\?\\UNC\\server\\share\\', pp.given_path
    assert_equal '\\\\?\\UNC\\server\\share\\', pp.absolute_path
    assert_equal '\\\\?\\UNC\\server\\share\\', pp.compare_path
    assert_equal '\\\\?\\UNC\\server\\share', pp.volume
    assert_equal '\\', pp.directory
    assert_equal '\\\\?\\UNC\\server\\share\\', pp.directory_path
    assert_equal '\\\\?\\UNC\\server\\share\\', pp.dirname
    assert_equal [ '\\' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_root_UNC_form6

    pp = ParsedPath.new('\\\\.\\{some-device-id}\\')

    assert_equal '\\\\.\\{some-device-id}\\', pp.given_path
    assert_equal '\\\\.\\{some-device-id}\\', pp.absolute_path
    assert_equal '\\\\.\\{some-device-id}\\', pp.compare_path
    assert_equal '\\\\.\\{some-device-id}', pp.volume
    assert_equal '\\', pp.directory
    assert_equal '\\\\.\\{some-device-id}\\', pp.directory_path
    assert_equal '\\\\.\\{some-device-id}\\', pp.dirname
    assert_equal [ '\\' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_dir

    pp = ParsedPath.new('G:\\\\abc\\\\')

    assert_equal 'G:\\\\abc\\\\', pp.given_path
    assert_equal 'G:\\abc\\', pp.absolute_path
    assert_equal 'G:\\ABC\\', pp.compare_path
    assert_equal '\\abc\\', pp.directory
    assert_equal 'G:', pp.volume
    assert_equal 'G:\\abc\\', pp.directory_path
    assert_equal 'G:\\abc\\', pp.dirname
    assert_equal [ '\\', 'abc\\' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_dir_with_trailing_dot

    pp = ParsedPath.new('G:\\abc\\.')

    assert_equal 'G:\\abc\\.', pp.given_path
    assert_equal 'G:\\abc\\', pp.absolute_path
    assert_equal 'G:\\ABC\\', pp.compare_path
    assert_equal 'G:', pp.volume
    assert_equal '\\abc\\', pp.directory
    assert_equal 'G:\\abc\\', pp.directory_path
    assert_equal 'G:\\abc\\', pp.dirname
    assert_equal [ '\\', 'abc\\' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_file

    pp = ParsedPath.new('G:\\file.ext')

    assert_equal 'G:\\file.ext', pp.given_path
    assert_equal 'G:\\file.ext', pp.absolute_path
    assert_equal 'G:\\FILE.EXT', pp.compare_path
    assert_equal 'G:', pp.volume
    assert_equal '\\', pp.directory
    assert_equal 'G:\\', pp.directory_path
    assert_equal 'G:\\', pp.dirname
    assert_equal [ '\\' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_file_without_extension

    pp = ParsedPath.new('G:\\file')

    assert_equal 'G:\\file', pp.given_path
    assert_equal 'G:\\file', pp.absolute_path
    assert_equal 'G:\\FILE', pp.compare_path
    assert_equal 'G:', pp.volume
    assert_equal '\\', pp.directory
    assert_equal 'G:\\', pp.directory_path
    assert_equal 'G:\\', pp.dirname
    assert_equal [ '\\' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_file_without_stem

    pp = ParsedPath.new('H:\\.ext')

    assert_equal 'H:\\.ext', pp.given_path
    assert_equal 'H:\\.ext', pp.absolute_path
    assert_equal 'H:\\.EXT', pp.compare_path
    assert_equal 'H:', pp.volume
    assert_equal '\\', pp.directory
    assert_equal 'H:\\', pp.directory_path
    assert_equal 'H:\\', pp.dirname
    assert_equal [ '\\' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_long_path

    pp = ParsedPath.new('C:/dir-1/dir-2/dir-3/dir-4/./dir-5/dir-6/../file.ext')

    assert_equal 'C:/dir-1/dir-2/dir-3/dir-4/./dir-5/dir-6/../file.ext', pp.given_path
    assert_equal 'C:/dir-1/dir-2/dir-3/dir-4/dir-5/file.ext', pp.absolute_path
    assert_equal 'C:/DIR-1/DIR-2/DIR-3/DIR-4/DIR-5/FILE.EXT', pp.compare_path
    assert_equal 'C:', pp.volume
    assert_equal '/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.directory
    assert_equal 'C:/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.directory_path
    assert_equal 'C:/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.dirname
    assert_equal [ '/', 'dir-1/', 'dir-2/', 'dir-3/', 'dir-4/', 'dir-5/' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_long_path_from_srd1

    srd = 'C:\\dir-1\\dir-2\\dir-C\\dir-D'
    pp = ParsedPath.new('C:/dir-1/dir-2/dir-3/dir-4/./dir-5/dir-6/../file.ext', srd)

    assert_equal 'C:/dir-1/dir-2/dir-3/dir-4/./dir-5/dir-6/../file.ext', pp.given_path
    assert_equal 'C:/dir-1/dir-2/dir-3/dir-4/dir-5/file.ext', pp.absolute_path
    assert_equal 'C:/DIR-1/DIR-2/DIR-3/DIR-4/DIR-5/FILE.EXT', pp.compare_path
    assert_equal 'C:', pp.volume
    assert_equal '/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.directory
    assert_equal 'C:/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.directory_path
    assert_equal 'C:/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.dirname
    assert_equal [ '/', 'dir-1/', 'dir-2/', 'dir-3/', 'dir-4/', 'dir-5/' ], pp.directory_parts
    assert_equal 'file.ext', pp.file_full_name
    assert_equal 'file.ext', pp.basename
    assert_equal 'file', pp.file_name_only
    assert_equal 'file', pp.stem
    assert_equal '.ext', pp.file_extension
    assert_equal '.ext', pp.extension
    assert_equal 'C:\\dir-1\\dir-2\\dir-C\\dir-D\\', pp.search_directory
    assert_equal '..\\..\\dir-3\\dir-4\\dir-5\\file.ext', pp.search_relative_path
    assert_equal '..\\..\\dir-3\\dir-4\\dir-5\\', pp.search_relative_directory_path
    assert_equal [ '..\\', '..\\', 'dir-3\\', 'dir-4\\', 'dir-5\\' ], pp.search_relative_directory_parts

    assert_equal pp.directory, pp.directory_parts.join
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_long_path_missing_volume

    pp = ParsedPath.new('/dir-1/dir-2/dir-3/dir-4/./dir-5/dir-6/../file.ext', pwd: 'D:\\')

    assert_equal '/dir-1/dir-2/dir-3/dir-4/./dir-5/dir-6/../file.ext', pp.given_path
    assert_equal 'D:/dir-1/dir-2/dir-3/dir-4/dir-5/file.ext', pp.absolute_path
    assert_equal 'D:/DIR-1/DIR-2/DIR-3/DIR-4/DIR-5/FILE.EXT', pp.compare_path
    assert_equal 'D:', pp.volume
    assert_equal '/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.directory
    assert_equal 'D:/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.directory_path
    assert_equal 'D:/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.dirname
    assert_equal [ '/', 'dir-1/', 'dir-2/', 'dir-3/', 'dir-4/', 'dir-5/' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_long_path_with_short_directory_names

    pp = ParsedPath.new('C:/1/2/3/4/./5/6/../file.ext')

    assert_equal 'C:/1/2/3/4/./5/6/../file.ext', pp.given_path
    assert_equal 'C:/1/2/3/4/5/file.ext', pp.absolute_path
    assert_equal 'C:/1/2/3/4/5/FILE.EXT', pp.compare_path
    assert_equal 'C:', pp.volume
    assert_equal '/1/2/3/4/5/', pp.directory
    assert_equal 'C:/1/2/3/4/5/', pp.directory_path
    assert_equal 'C:/1/2/3/4/5/', pp.dirname
    assert_equal [ '/', '1/', '2/', '3/', '4/', '5/' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_unrooted_one_file

    pwd = '/some-directory'

    pp = ParsedPath.new('file.ext', pwd: pwd)

    assert_equal 'file.ext', pp.given_path
    assert_equal '/some-directory\\file.ext', pp.absolute_path
    assert_equal '/SOME-DIRECTORY\\FILE.EXT', pp.compare_path
    assert_nil pp.volume
    assert_equal '/some-directory\\', pp.directory
    assert_equal '/some-directory\\', pp.directory_path
    assert_equal '/some-directory\\', pp.dirname
    assert_equal [ '/', 'some-directory\\' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_unrooted_dir_file

    pwd = '/some-directory'

    pp = ParsedPath.new('sub-dir/file.ext', pwd: pwd)

    assert_equal 'sub-dir/file.ext', pp.given_path
    assert_equal '/some-directory\\sub-dir/file.ext', pp.absolute_path
    assert_equal '/SOME-DIRECTORY\\SUB-DIR/FILE.EXT', pp.compare_path
    assert_nil pp.volume
    assert_equal '/some-directory\\sub-dir/', pp.directory
    assert_equal '/some-directory\\sub-dir/', pp.directory_path
    assert_equal '/some-directory\\sub-dir/', pp.dirname
    assert_equal [ '/', 'some-directory\\', 'sub-dir/' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_unrooted_dir_file_2

    locator = Object.new

    locator.define_singleton_method(:pwd) { '/some-directory' }

    pp = ParsedPath.new('sub-dir/file.ext', locator: locator)

    assert_equal 'sub-dir/file.ext', pp.given_path
    assert_equal '/some-directory\\sub-dir/file.ext', pp.absolute_path
    assert_equal '/SOME-DIRECTORY\\SUB-DIR/FILE.EXT', pp.compare_path
    assert_nil pp.volume
    assert_equal '/some-directory\\sub-dir/', pp.directory
    assert_equal '/some-directory\\sub-dir/', pp.directory_path
    assert_equal '/some-directory\\sub-dir/', pp.dirname
    assert_equal [ '/', 'some-directory\\', 'sub-dir/' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_UNC_form_5

    gp = '\\\\?\\UNC\\127.0.0.1:3000\\shared-stuff\\dir-1\\dir-1.2\\file.ext'

    pp = ParsedPath.new(gp)

    assert_equal gp, pp.given_path
    assert_equal gp, pp.absolute_path
    assert_equal '\\\\?\\UNC\\127.0.0.1:3000\\shared-stuff\\DIR-1\\DIR-1.2\\FILE.EXT', pp.compare_path
    assert_equal '\\\\?\\UNC\\127.0.0.1:3000\\shared-stuff', pp.volume
    assert_equal '\\dir-1\\dir-1.2\\', pp.directory
    assert_equal '\\\\?\\UNC\\127.0.0.1:3000\\shared-stuff\\dir-1\\dir-1.2\\', pp.directory_path
    assert_equal '\\\\?\\UNC\\127.0.0.1:3000\\shared-stuff\\dir-1\\dir-1.2\\', pp.dirname
    assert_equal [ '\\', 'dir-1\\', 'dir-1.2\\' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.volume}#{pp.directory_parts.join}#{pp.basename}"
  end
end


# ############################## end of file ############################# #


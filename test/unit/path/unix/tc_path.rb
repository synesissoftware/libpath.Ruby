#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 4), 'lib')


require 'libpath/path/unix'

require 'xqsr3/extensions/test/unit'
require 'test/unit'

require 'libpath/internal_/platform'


class Test_existence_of_namespace_LibPath_Path_Unix < Test::Unit::TestCase

  def test_LibPath_module_exists

    assert defined?(::LibPath)
  end

  def test_LibPath_Path_module_exists

    assert defined?(::LibPath::Path)
  end

  def test_LibPath_Path_Unix_module_exists

    assert defined?(::LibPath::Path::Unix)
  end

  def test_LibPath_Path_Unix_ParsedPath_class_exists

    assert defined?(::LibPath::Path::Unix::ParsedPath)
  end
end

class Test_LibPath_Path_Unix_ParsedPath < Test::Unit::TestCase

  include ::LibPath::Path::Unix

  def test_nil

    assert_raise(::ArgumentError) { ParsedPath.new(nil) }
  end

  def test_empty

    assert_raise(::ArgumentError) { ParsedPath.new('') }
  end

  def test_root

    pp = ParsedPath.new('/')

    assert_equal '/', pp.given_path
    assert_equal '/', pp.absolute_path
    assert_equal '/', pp.compare_path
    assert_equal '/', pp.directory
    assert_equal '/', pp.directory_path
    assert_equal '/', pp.dirname
    assert_equal [ '/' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_root_from_srd_1

    srd = '/dir-1/dir-2'

    pp = ParsedPath.new('/', srd)

    assert_equal '/', pp.given_path
    assert_equal '/', pp.absolute_path
    assert_equal '/', pp.compare_path
    assert_equal '/', pp.directory
    assert_equal '/', pp.directory_path
    assert_equal '/', pp.dirname
    assert_equal [ '/' ], pp.directory_parts
    assert_nil pp.file_full_name
    assert_nil pp.basename
    assert_nil pp.file_name_only
    assert_nil pp.stem
    assert_nil pp.file_extension
    assert_nil pp.extension
    assert_equal '/dir-1/dir-2/', pp.search_directory
    assert_equal '../../', pp.search_relative_path
    assert_equal '../../', pp.search_relative_directory_path
    assert_equal [ '../', '../' ], pp.search_relative_directory_parts

    assert_equal pp.directory, pp.directory_parts.join
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_root_from_srd_2

    srd = '/'

    pp = ParsedPath.new('/', srd)

    assert_equal '/', pp.given_path
    assert_equal '/', pp.absolute_path
    assert_equal '/', pp.compare_path
    assert_equal '/', pp.directory
    assert_equal '/', pp.directory_path
    assert_equal '/', pp.dirname
    assert_equal [ '/' ], pp.directory_parts
    assert_nil pp.file_full_name
    assert_nil pp.basename
    assert_nil pp.file_name_only
    assert_nil pp.stem
    assert_nil pp.file_extension
    assert_nil pp.extension
    assert_equal '/', pp.search_directory
    assert_equal './', pp.search_relative_path
    assert_equal './', pp.search_relative_directory_path
    assert_equal [ './' ], pp.search_relative_directory_parts

    assert_equal pp.directory, pp.directory_parts.join
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_dir

    pp = ParsedPath.new('/abc/')

    assert_equal '/abc/', pp.given_path
    assert_equal '/abc/', pp.absolute_path
    assert_equal '/abc/', pp.compare_path
    assert_equal '/abc/', pp.directory
    assert_equal '/abc/', pp.directory_path
    assert_equal '/abc/', pp.dirname
    assert_equal [ '/', 'abc/' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_dir_from_srd

    srd = '/dir-1/dir-2'

    pp = ParsedPath.new('/abc/', srd)

    assert_equal '/abc/', pp.given_path
    assert_equal '/abc/', pp.absolute_path
    assert_equal '/abc/', pp.compare_path
    assert_equal '/abc/', pp.directory
    assert_equal '/abc/', pp.directory_path
    assert_equal '/abc/', pp.dirname
    assert_equal [ '/', 'abc/' ], pp.directory_parts
    assert_nil pp.file_full_name
    assert_nil pp.basename
    assert_nil pp.file_name_only
    assert_nil pp.stem
    assert_nil pp.file_extension
    assert_nil pp.extension
    assert_equal '/dir-1/dir-2/', pp.search_directory
    assert_equal '../../abc/', pp.search_relative_path
    assert_equal '../../abc/', pp.search_relative_directory_path
    assert_equal [ '../', '../', 'abc/' ], pp.search_relative_directory_parts

    assert_equal pp.directory, pp.directory_parts.join
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_dir_with_trailing_dot

    pp = ParsedPath.new('/abc/.')

    assert_equal '/abc/.', pp.given_path
    assert_equal '/abc/', pp.absolute_path
    assert_equal '/abc/', pp.compare_path
    assert_equal '/abc/', pp.directory
    assert_equal '/abc/', pp.directory_path
    assert_equal '/abc/', pp.dirname
    assert_equal [ '/', 'abc/' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_file

    pp = ParsedPath.new('/file.ext')

    assert_equal '/file.ext', pp.given_path
    assert_equal '/file.ext', pp.absolute_path
    assert_equal '/file.ext', pp.compare_path
    assert_equal '/', pp.directory
    assert_equal '/', pp.directory_path
    assert_equal '/', pp.dirname
    assert_equal [ '/' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_file_from_srd1

    srd = '/dir-1/dir-2'

    pp = ParsedPath.new('/file.ext', srd)

    assert_equal '/file.ext', pp.given_path
    assert_equal '/file.ext', pp.absolute_path
    assert_equal '/file.ext', pp.compare_path
    assert_equal '/', pp.directory
    assert_equal '/', pp.directory_path
    assert_equal '/', pp.dirname
    assert_equal [ '/' ], pp.directory_parts
    assert_equal 'file.ext', pp.file_full_name
    assert_equal 'file.ext', pp.basename
    assert_equal 'file', pp.file_name_only
    assert_equal 'file', pp.stem
    assert_equal '.ext', pp.file_extension
    assert_equal '.ext', pp.extension
    assert_equal '/dir-1/dir-2/', pp.search_directory
    assert_equal '../../file.ext', pp.search_relative_path
    assert_equal '../../', pp.search_relative_directory_path
    assert_equal [ '../', '../' ], pp.search_relative_directory_parts

    assert_equal pp.directory, pp.directory_parts.join
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_file_without_extension

    pp = ParsedPath.new('/file')

    assert_equal '/file', pp.given_path
    assert_equal '/file', pp.absolute_path
    assert_equal '/file', pp.compare_path
    assert_equal '/', pp.directory
    assert_equal '/', pp.directory_path
    assert_equal '/', pp.dirname
    assert_equal [ '/' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_file_without_stem

    pp = ParsedPath.new('/.ext')

    assert_equal '/.ext', pp.given_path
    assert_equal '/.ext', pp.absolute_path
    assert_equal '/.ext', pp.compare_path
    assert_equal '/', pp.directory
    assert_equal '/', pp.directory_path
    assert_equal '/', pp.dirname
    assert_equal [ '/' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_long_path

    pp = ParsedPath.new('/dir-1/dir-2/dir-3/dir-4/./dir-5/dir-6/../file.ext')

    assert_equal '/dir-1/dir-2/dir-3/dir-4/./dir-5/dir-6/../file.ext', pp.given_path
    assert_equal '/dir-1/dir-2/dir-3/dir-4/dir-5/file.ext', pp.absolute_path
    assert_equal '/dir-1/dir-2/dir-3/dir-4/dir-5/file.ext', pp.compare_path
    assert_equal '/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.directory
    assert_equal '/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.directory_path
    assert_equal '/dir-1/dir-2/dir-3/dir-4/dir-5/', pp.dirname
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
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_rooted_one_long_path_with_short_directory_names

    pp = ParsedPath.new('/1/2/3/4/./5/6/../file.ext')

    assert_equal '/1/2/3/4/./5/6/../file.ext', pp.given_path
    assert_equal '/1/2/3/4/5/file.ext', pp.absolute_path
    assert_equal '/1/2/3/4/5/file.ext', pp.compare_path
    assert_equal '/1/2/3/4/5/', pp.directory
    assert_equal '/1/2/3/4/5/', pp.directory_path
    assert_equal '/1/2/3/4/5/', pp.dirname
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
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_unrooted_one_file

    pwd = '/some-directory'

    pp = ParsedPath.new('file.ext', pwd: pwd)

    assert_equal 'file.ext', pp.given_path
    assert_equal '/some-directory/file.ext', pp.absolute_path
    assert_equal '/some-directory/file.ext', pp.compare_path
    assert_equal '/some-directory/', pp.directory
    assert_equal '/some-directory/', pp.directory_path
    assert_equal '/some-directory/', pp.dirname
    assert_equal [ '/', 'some-directory/' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_unrooted_one_file_from_srd

    pwd = '/some-directory'
    srd = '/dir-1/dir-2/'

    pp = ParsedPath.new('file.ext', srd, pwd: pwd)

    assert_equal 'file.ext', pp.given_path
    assert_equal '/some-directory/file.ext', pp.absolute_path
    assert_equal '/some-directory/file.ext', pp.compare_path
    assert_equal '/some-directory/', pp.directory
    assert_equal '/some-directory/', pp.directory_path
    assert_equal '/some-directory/', pp.dirname
    assert_equal [ '/', 'some-directory/' ], pp.directory_parts
    assert_equal 'file.ext', pp.file_full_name
    assert_equal 'file.ext', pp.basename
    assert_equal 'file', pp.file_name_only
    assert_equal 'file', pp.stem
    assert_equal '.ext', pp.file_extension
    assert_equal '.ext', pp.extension
    assert_equal srd, pp.search_directory
    assert_equal '../../some-directory/file.ext', pp.search_relative_path
    assert_equal '../../some-directory/', pp.search_relative_directory_path
    assert_equal [ '../', '../', 'some-directory/' ], pp.search_relative_directory_parts

    assert_equal pp.directory, pp.directory_parts.join
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_unrooted_dir_file

    pwd = '/some-directory'

    pp = ParsedPath.new('sub-dir/file.ext', pwd: pwd)

    assert_equal 'sub-dir/file.ext', pp.given_path
    assert_equal '/some-directory/sub-dir/file.ext', pp.absolute_path
    assert_equal '/some-directory/sub-dir/file.ext', pp.compare_path
    assert_equal '/some-directory/sub-dir/', pp.directory
    assert_equal '/some-directory/sub-dir/', pp.directory_path
    assert_equal '/some-directory/sub-dir/', pp.dirname
    assert_equal [ '/', 'some-directory/', 'sub-dir/' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_unrooted_dir_file_2

    locator = Object.new

    locator.define_singleton_method(:pwd) { '/some-directory' }

    pp = ParsedPath.new('sub-dir/file.ext', locator: locator)

    assert_equal 'sub-dir/file.ext', pp.given_path
    assert_equal '/some-directory/sub-dir/file.ext', pp.absolute_path
    assert_equal '/some-directory/sub-dir/file.ext', pp.compare_path
    assert_equal '/some-directory/sub-dir/', pp.directory
    assert_equal '/some-directory/sub-dir/', pp.directory_path
    assert_equal '/some-directory/sub-dir/', pp.dirname
    assert_equal [ '/', 'some-directory/', 'sub-dir/' ], pp.directory_parts
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
    assert_equal pp.absolute_path, "#{pp.directory_parts.join}#{pp.basename}"
  end

  def test_recls_stat_case_1

    pwd = '/Users/matthewwilson/dev/freelibs/recls/100/recls.Ruby/trunk/'
    srd = '.'

    pp = ParsedPath.new('.', srd, pwd: pwd)

    assert_equal '.', pp.given_path
    assert_equal pwd, pp.absolute_path
    assert_equal pwd, pp.compare_path
    assert_equal pwd, pp.directory
    assert_equal pwd, pp.directory_path
    assert_equal pwd, pp.dirname
    assert_equal [ '/', 'Users/', 'matthewwilson/', 'dev/', 'freelibs/', 'recls/', '100/', 'recls.Ruby/', 'trunk/' ], pp.directory_parts
    assert_nil pp.file_full_name
    assert_nil pp.basename
    assert_nil pp.file_name_only
    assert_nil pp.stem
    assert_nil pp.file_extension
    assert_nil pp.extension
    assert_equal pwd, pp.search_directory
    assert_equal './', pp.search_relative_path
    assert_equal './', pp.search_relative_directory_path
    assert_equal [ './' ], pp.search_relative_directory_parts
  end

  def test_recls_stat_case_2

    pwd   = '/Users/matthewwilson/dev/freelibs/recls/100/recls.Ruby/trunk/'
    home  = '/Users/matthewwilson'
    srd   = '~'

    pp = ParsedPath.new('.', srd, home: home, pwd: pwd)

    assert_equal '.', pp.given_path
    assert_equal pwd, pp.absolute_path
    assert_equal pwd, pp.compare_path
    assert_equal pwd, pp.directory
    assert_equal pwd, pp.directory_path
    assert_equal pwd, pp.dirname
    assert_equal [ '/', 'Users/', 'matthewwilson/', 'dev/', 'freelibs/', 'recls/', '100/', 'recls.Ruby/', 'trunk/' ], pp.directory_parts
    assert_nil pp.file_full_name
    assert_nil pp.basename
    assert_nil pp.file_name_only
    assert_nil pp.stem
    assert_nil pp.file_extension
    assert_nil pp.extension
    assert_equal '/Users/matthewwilson/', pp.search_directory
    assert_equal 'dev/freelibs/recls/100/recls.Ruby/trunk/', pp.search_relative_path
    assert_equal 'dev/freelibs/recls/100/recls.Ruby/trunk/', pp.search_relative_directory_path
    assert_equal [ 'dev/', 'freelibs/', 'recls/', '100/', 'recls.Ruby/', 'trunk/' ], pp.search_relative_directory_parts
  end

  def test_recls_stat_case_3

    pwd   = '/Users/matthewwilson/dev/freelibs/recls/100/recls.Ruby/trunk/'
    home  = '/Users/matthewwilson'
    srd   = '.'

    pp = ParsedPath.new('~', srd, home: home, pwd: pwd)

    assert_equal '~', pp.given_path
    assert_equal '/Users/matthewwilson/', pp.absolute_path
    assert_equal '/Users/matthewwilson/', pp.compare_path
    assert_equal '/Users/matthewwilson/', pp.directory
    assert_equal '/Users/matthewwilson/', pp.directory_path
    assert_equal '/Users/matthewwilson/', pp.dirname
    assert_equal [ '/', 'Users/', 'matthewwilson/' ], pp.directory_parts
    assert_nil pp.file_full_name
    assert_nil pp.basename
    assert_nil pp.file_name_only
    assert_nil pp.stem
    assert_nil pp.file_extension
    assert_nil pp.extension
    assert_equal pwd, pp.search_directory
    assert_equal '../../../../../../', pp.search_relative_path
    assert_equal '../../../../../../', pp.search_relative_directory_path
    assert_equal [ '../', '../', '../', '../', '../', '../' ], pp.search_relative_directory_parts
  end
end


# ############################## end of file ############################# #


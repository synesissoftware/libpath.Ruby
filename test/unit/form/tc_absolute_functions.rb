#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 3), 'lib')

require 'libpath/form'

require 'test/unit'

require 'xqsr3/extensions/test/unit'

require 'libpath/internal_/platform'

class Test_existence_of_namespace_LibPath_Form < Test::Unit::TestCase

  def test_LibPath_module_exists

    assert defined?(::LibPath)
  end

  def test_LibPath_Form_module_exists

    assert defined?(::LibPath::Form)
  end
end

class Test_path_is_absolute < Test::Unit::TestCase

  include ::LibPath::Form

  if $DEBUG

    def test_with_nil

      assert_raise(::ArgumentError) { path_is_absolute?(nil) }
    end
  end

  def test_empty

    assert_false path_is_absolute?('')
  end

  if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

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
  end

  if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

    def test_absolute_paths_from_drive

      assert path_is_absolute?('C:\\')
      assert path_is_absolute?('C:\\abc')
      assert path_is_absolute?('C:\\abc\\')

      assert_false path_is_absolute?('C:')
      assert_false path_is_absolute?('C:abc')
      assert_false path_is_absolute?('C:abc\\')
    end
  end

  def test_absolute_paths_from_root

    if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

      assert_false path_is_absolute?('\\')
      assert_false path_is_absolute?('\\\\')
      assert_false path_is_absolute?('\\abc')

      assert_false path_is_absolute?('/')
      assert_false path_is_absolute?('//')
      assert_false path_is_absolute?('/abc')
    else

      assert path_is_absolute?('/')
      assert path_is_absolute?('//')
      assert path_is_absolute?('/abc')
    end
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

class Test_path_is_homed < Test::Unit::TestCase

  include ::LibPath::Form

  if $DEBUG

    def test_with_nil

      assert_raise(::ArgumentError) { path_is_homed?(nil) }
    end
  end

  def test_empty

    assert_false path_is_homed?('')
  end

  if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

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
  end

  if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

    def test_absolute_paths_from_drive

      assert_false path_is_homed?('C:\\')
      assert_false path_is_homed?('C:\\abc')
      assert_false path_is_homed?('C:\\abc\\')
    end
  end

  def test_absolute_paths_from_root

    if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

      assert_false path_is_homed?('\\')
      assert_false path_is_homed?('\\\\')
      assert_false path_is_homed?('\\abc')
    end

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

class Test_path_is_rooteds < Test::Unit::TestCase

  include ::LibPath::Form

  if $DEBUG

    def test_with_nil

      assert_raise(::ArgumentError) { path_is_rooted?(nil) }
    end
  end

  def test_empty

    assert_false path_is_rooted?('')
  end

  if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

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
  end

  if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

    def test_absolute_paths_from_drive

      assert path_is_rooted?('C:\\')
      assert path_is_rooted?('C:\\abc')
      assert path_is_rooted?('C:\\abc\\')

      assert_false path_is_rooted?('C:')
      assert_false path_is_rooted?('C:abc')
      assert_false path_is_rooted?('C:abc\\')
    end
  end

  def test_absolute_paths_from_root

    if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

      assert path_is_rooted?('\\')
      assert_false path_is_rooted?('\\\\')
      assert path_is_rooted?('\\abc')
    end

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

if ::LibPath::Internal_::Platform::Constants::PLATFORM_IS_WINDOWS then

  class Test_path_is_UNCs < Test::Unit::TestCase

    include ::LibPath::Form

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
      assert path_is_UNC?('\\\\server\\share')

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
end


# ############################## end of file ############################# #


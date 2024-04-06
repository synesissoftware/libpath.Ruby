#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 4), 'lib')


require 'libpath/util/unix'

require 'test/unit'


class Test_LibPath_Util_Unix_make_path_canonical < Test::Unit::TestCase

  F = ::LibPath::Util::Unix

  def test_empty

    assert_equal '', F.make_path_canonical('')
  end

  def test_one_dot

    assert_equal './', F.make_path_canonical('.')
    assert_equal './', F.make_path_canonical('./')
    assert_equal './', F.make_path_canonical('./.')
    assert_equal './', F.make_path_canonical('./.')
    assert_equal './', F.make_path_canonical('././')
    assert_equal './', F.make_path_canonical('.//./')
    assert_equal './', F.make_path_canonical('.////./')
    assert_equal './', F.make_path_canonical('././.')
    assert_equal './', F.make_path_canonical('./././')
  end

  def test_two_dots

    assert_equal '../', F.make_path_canonical('..')
    assert_equal '../', F.make_path_canonical('../')
    assert_equal '../', F.make_path_canonical('../.')
    assert_equal '../', F.make_path_canonical('.././')
    assert_equal '../', F.make_path_canonical('..//./')
    assert_equal '../', F.make_path_canonical('..////./')
    assert_equal '../', F.make_path_canonical('.././.')
  end

  def test_unresolveable

    assert_equal '../', F.make_path_canonical('..')
    assert_equal '../', F.make_path_canonical('../')

    assert_equal '../dir-1', F.make_path_canonical('../dir-1')
    assert_equal '../dir-1/', F.make_path_canonical('../dir-1/')

    assert_equal '../../', F.make_path_canonical('../..')
    assert_equal '../../', F.make_path_canonical('../../')

    assert_equal '../../dir-1', F.make_path_canonical('../../dir-1')
    assert_equal '../../dir-1/', F.make_path_canonical('../../dir-1/')
  end

  def test_partially_resolveable

    assert_equal '../', F.make_path_canonical('../dir-1/..')
    assert_equal '../', F.make_path_canonical('../dir-1/../')

    assert_equal '../abc', F.make_path_canonical('../dir-1/../abc')
    assert_equal '../abc/', F.make_path_canonical('../dir-1/../abc/')

    assert_equal '../../', F.make_path_canonical('../../dir-1/..')
    assert_equal '../../', F.make_path_canonical('../../dir-1/../')

    assert_equal '../../abc', F.make_path_canonical('../../dir-1/../abc')
    assert_equal '../../abc/', F.make_path_canonical('../../dir-1/../abc/')

    assert_equal '/dir.14/', F.make_path_canonical('/dir.14/dir.2/..')
    assert_equal 'dir.14/', F.make_path_canonical('dir.14/dir.2/..')

    assert_equal '/', F.make_path_canonical('/dir.14/dir.2/../..')
    assert_equal '/', F.make_path_canonical('/dir.14/dir.2/../../..')
    assert_equal './', F.make_path_canonical('dir.14/dir.2/../..')
  end

  def test_basenames

    assert_equal 'a', F.make_path_canonical('a')

    assert_equal 'file.ext', F.make_path_canonical('file.ext')

    assert_equal '../', F.make_path_canonical('..')
  end

  def test_no_dots

    assert_equal 'abc/def', F.make_path_canonical('abc/def')
    assert_equal 'abc/def', F.make_path_canonical('abc//def')
    assert_equal 'abc/def', F.make_path_canonical('abc///def')
  end

  def test_one_dots_directories

    assert_equal 'abc', F.make_path_canonical('./abc')
    assert_equal 'abc/', F.make_path_canonical('./abc/')

    assert_equal 'abc', F.make_path_canonical('././abc')
    assert_equal 'abc/', F.make_path_canonical('././abc/')

    assert_equal 'abc', F.make_path_canonical('./././././././././abc')
    assert_equal 'abc/', F.make_path_canonical('./././././././././abc/')

    assert_equal 'abc/', F.make_path_canonical('abc/.')
    assert_equal 'abc/', F.make_path_canonical('abc/./')

    assert_equal 'abc/', F.make_path_canonical('./abc/.')
    assert_equal 'abc/', F.make_path_canonical('./abc/./')
  end

  def test_two_dots_directories

    assert_equal '../', F.make_path_canonical('..')
    assert_equal '../', F.make_path_canonical('../')

    assert_equal '../abc', F.make_path_canonical('../abc')
    assert_equal '../abc/', F.make_path_canonical('../abc/')

    assert_equal './', F.make_path_canonical('abc/..')
    assert_equal './', F.make_path_canonical('abc/../')

    assert_equal 'def', F.make_path_canonical('abc/../def')
    assert_equal 'def/', F.make_path_canonical('abc/../def/')

    assert_equal './', F.make_path_canonical('abc/../def/..')
    assert_equal './', F.make_path_canonical('abc/../def/../')

    assert_equal '../dir-2/', F.make_path_canonical('../dir-1/../dir-2/')
    assert_equal '../dir-2', F.make_path_canonical('../dir-1/../dir-2')
    assert_equal '/dir-2', F.make_path_canonical('/../dir-1/../dir-2')
    assert_equal '/', F.make_path_canonical('/../')
    assert_equal '/', F.make_path_canonical('/..')
    assert_equal('/', F.make_path_canonical('/dir.14/dir.2/../..'))
    assert_equal('/', F.make_path_canonical('/dir.14/dir.2/../../..'))
  end
end


# ############################## end of file ############################# #


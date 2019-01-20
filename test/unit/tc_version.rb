#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 2), 'lib')

require 'libpath/version'

require 'test/unit'

class Test_version < Test::Unit::TestCase

	def test_has_VERSION

		assert defined? LibPath::VERSION
	end

	def test_has_VERSION_MAJOR

		assert defined? LibPath::VERSION_MAJOR
	end

	def test_has_VERSION_MINOR

		assert defined? LibPath::VERSION_MINOR
	end

	def test_has_VERSION_REVISION

		assert defined? LibPath::VERSION_REVISION
	end

	def test_VERSION_has_consistent_format

		assert_equal LibPath::VERSION, "#{LibPath::VERSION_MAJOR}.#{LibPath::VERSION_MINOR}.#{LibPath::VERSION_REVISION}"
	end

	def test_VERSION_greater_than

		assert_operator LibPath::VERSION, :>=, '0.0.10'
	end
end


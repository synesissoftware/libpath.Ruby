#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 3), 'lib')

require 'libpath/util'

require 'test/unit'

require 'libpath/internal_/platform'

class Test_LibPath_Util_derive_relative_path < Test::Unit::TestCase

	F = ::LibPath::Util

	def test_nils

	end
end


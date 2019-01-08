#!/usr/bin/env ruby

#############################################################################
# File:         test/performance/benchmark_rindex2.rb
#
# Purpose:      Determines whether it's better to use String-case of regex
#               to match Windows-drive letters
#
# Created:      8th January 2019
# Updated:      8th January 2019
#
# Author:       Matthew Wilson
#
#############################################################################

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 2), 'lib')

require 'libpath/internal_/windows/drive'

require 'benchmark'

ITERATIONS	=	100000

ITEMS		=	(0...ITERATIONS).map { rand(0...100) }.map { |n| n > 51 ? ' ' : (n % 26 + (n < 26 ? 'A' : 'a').ord).chr }

Benchmark.bm(10) do |x|

	x.report('Regex:') { ITEMS.each { |ch| /^[a-z]/i =~ ch } }
	x.report('cidl?:') { ITEMS.each { |ch| ::LibPath::Internal_::Windows::Drive.character_is_drive_letter?(ch) } }
end


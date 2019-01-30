#! /usr/bin/env ruby

#############################################################################
# File:         test/performance/benchmark_split.rb
#
# Purpose:      Determines whether split is faster without regex
#
# Created:      15th January 2019
# Updated:      15th January 2019
#
# Author:       Matthew Wilson
#
#############################################################################

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 2), 'lib')

require 'benchmark'

ITERATIONS	=	10

STRINGS		=	(1..1000).map { |n| '/abc' * n }

# benchmark

Benchmark.bm(15) do |x|

	x.report('by char:') { (0...ITERATIONS).each { STRINGS.each { |s| s.split('/') } } }
	x.report('by regex:') { (0...ITERATIONS).each { STRINGS.each { |s| s.split(/\//) } } }
	x.report('by regex (sl):') { (0...ITERATIONS).each { STRINGS.each { |s| s.split(/[\\\/]/) } } }
end



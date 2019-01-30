#! /usr/bin/env ruby

#############################################################################
# File:         test/performance/benchmark_gsub_string_or_regex.rb
#
# Purpose:      Determine whether gsub using a string is faster than using a
#               regex
#
# Created:      27th January 2019
# Updated:      27th January 2019
#
# Author:       Matthew Wilson
#
#############################################################################

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 2), 'lib')

require 'benchmark'

ITERATIONS	=	100000

STRINGS	=	[

	'abcdefghijklmnopqrstuvwxyz',
	'a\\b/c\\d/e\\f/g\\h/i\\j/k\\l/m\\n/o\\p/q\\r/s\\t/u\\v/w\\x/y\\z/',
	''
]

h = {
	'/'	=>	'\\'
}

Benchmark.bm(24) do |x|

	x.report('gsub by str:') { (0...ITERATIONS).each { STRINGS.each { |s| s.gsub('/', '\\') }}}
	x.report('gsub by str (?):') { (0...ITERATIONS).each { STRINGS.each { |s| s.gsub('/', '\\') if s.include?('/') }}}
	x.report('gsub by regex:') { (0...ITERATIONS).each { STRINGS.each { |s| s.gsub(/\//, '\\') }}}
	x.report('gsub by regex (?):') { (0...ITERATIONS).each { STRINGS.each { |s| s.gsub(/\//, '\\') if s.include?('/') }}}
	x.report('tr:') { (0...ITERATIONS).each { STRINGS.each { |s| s.tr('/', '\\') }}}
	x.report('tr (?):') { (0...ITERATIONS).each { STRINGS.each { |s| s.tr('/', '\\') if s.include?('/') }}}
	x.report('tr!:') { (0...ITERATIONS).each { STRINGS.each { |s| s.tr!('/', '\\') }}}

	puts
end


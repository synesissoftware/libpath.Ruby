#!/usr/bin/env ruby

#############################################################################
# File:         test/performance/benchmark_rindex2.rb
#
# Purpose:      Determines whether it's better to use rindex() twice for
#               Windows-slashes or once with a regex
#
# Created:      8th January 2019
# Updated:      8th January 2019
#
# Author:       Matthew Wilson
#
#############################################################################

$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 2), 'lib')

require 'benchmark'

ITERATIONS	=	100000

SMALL_STRINGS	=	[

	'C:\dir0\dir1/dir2',
	'C:\dir0\dir1/dir2\dir3\dir4/',
	'C:/dir0/dir1\dir2',
]

LONG_STRINGS	=	[

	'C:' + '\dir' * 1000,
	'C:' + '/dir' * 1000,
	'C:' + '\dir/dir' * 500,
]

def by_two_calls(s)

	ri_backward	=	s.rindex('\\')
	ri_forward	=	s.rindex('/')

	if ri_backward

		if ri_forward

			ri_forward > ri_backward ? ri_forward : ri_backward
		else

			ri_backward
		end
	else

		ri_forward
	end
end

def by_regex(s)

	s.rindex(/[\\\/]/)
end

def by_manual(s)

	(1..s.size).each do |ix|

		ch = s[-ix]

		if '/' == ch || '\\' == ch

			return s.size - ix
		end
	end
end

# check

SMALL_STRINGS.each do |ss|

	r_2c	=	by_two_calls(ss)
	r_re	=	by_regex(ss)
	r_man	=	by_manual(ss)

	if r_2c != r_re || r_2c != r_man

		abort "For string '#{ss}' results differ: by_two_calls()=#{r_2c}; by_regex()=#{r_re}; by_manual()=#{r_man}"
	end
end

LONG_STRINGS.each do |ss|

	r_2c	=	by_two_calls(ss)
	r_re	=	by_regex(ss)
	r_man	=	by_manual(ss)

	if r_2c != r_re || r_2c != r_man

		abort "For string '#{ss}' results differ: by_two_calls()=#{r_2c}; by_regex()=#{r_re}; by_manual()=#{r_man}"
	end
end

# benchmark

Benchmark.bm(12) do |x|

	x.report('rindex x 2:') { (0...ITERATIONS).each { SMALL_STRINGS.each { |ss| by_two_calls(ss) } } }
	x.report('Regex:') { (0...ITERATIONS).each { SMALL_STRINGS.each { |ss| by_regex(ss) } } }
	x.report('manual:') { (0...ITERATIONS).each { SMALL_STRINGS.each { |ss| by_manual(ss) } } }
end



#! /usr/bin/env ruby

#############################################################################
# File:     test/performance/benchmark_drive_letter.rb
#
# Purpose:  Determines whether it's better to use String-case of regex to
#           match Windows-drive letters
#
# Created:  8th January 2019
# Updated:  6th April 2024
#
# Author:   Matthew Wilson
#
#############################################################################


$:.unshift File.join(File.dirname(__FILE__), *(['..'] * 2), 'lib')


require 'libpath/internal_/windows/drive'

require 'benchmark'


include ::LibPath::Internal_::Windows


ITERATIONS  = 100000

ITEMS       = (0...ITERATIONS).map { rand(0...100) }.map { |n| n > 51 ? ' ' : (n % 26 + (n < 26 ? 'A' : 'a').ord).chr }

def is_drive_letter_1? c

  if c.valid_encoding?

    co = c.ord

    return true if co >= 65 && co <= 90

    return true if co >= 97 && co <= 122

    return false
  end
end

def is_drive_letter_2? c

  co = c.ord

  return true if (64..90).include? co

  return true if (97..122).include? co

  return false
end


# benchmark

Benchmark.bm(10) do |x|

  x.report('Regex:') { ITEMS.each { |ch| /^[a-zA-Z]/ =~ ch } }
  x.report('Regex/i:') { ITEMS.each { |ch| /^[a-z]/i =~ ch } }
  x.report('cidl?:') { ITEMS.each { |ch| Drive.character_is_drive_letter?(ch) } }
  x.report('idl-1?:') { ITEMS.each { |ch| is_drive_letter_1?(ch) } }
  x.report('idl-2?:') { ITEMS.each { |ch| is_drive_letter_2?(ch) } }
end


# ############################## end of file ############################# #


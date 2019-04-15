#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'libpath/path'

arg0 = ARGV[0] or abort "USAGE: <name> [<search-dir>]"
arg1 = ARGV[1]

path = LibPath::Path::ParsedPath.new arg0, arg1

puts "path obtained from '#{arg0}'" + (arg1 ? " (with search directory '#{arg1}')" : '') + ':'

puts path


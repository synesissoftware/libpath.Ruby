#! /usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'libpath/path'


PATH_ATTRIBUTES = %i{

  given_path
  absolute_path
  compare_path
  directory
  directory_path
  dirname
  directory_parts
  file_full_name
  basename
  file_name_only
  stem
  file_extension
  extension
  search_directory
  search_relative_path
  search_relative_directory_path
  search_relative_directory_parts
}


arg0 = ARGV[0] or abort "USAGE: <name> [<search-dir>]"
arg1 = ARGV[1]

path = LibPath::Path::ParsedPath.new arg0, arg1

puts "path obtained from '#{arg0}'" + (arg1 ? " (with search directory '#{arg1}')" : '') + ':'
puts

puts "\tpath: #{path}"
puts

puts "\tall attributes:"

max_name_len = PATH_ATTRIBUTES.map { |sym| sym.to_s.size }.max_by { |s| s }
max_type_len = PATH_ATTRIBUTES.map { |sym| path.send(sym).class.to_s.size }.max_by { |s| s }

PATH_ATTRIBUTES.each do |attr|

  name  = attr.to_s
  value = path.send(attr)
  type  = value.class

  puts "\t\t#{name.to_s.rjust(max_name_len)} (#{type.to_s.rjust(max_type_len)}) : #{value}"
end


# ############################## end of file ############################# #


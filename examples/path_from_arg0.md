# libpath.Ruby Example - **path_from_arg0**

## Summary

Simple example illustrating creation of an instance of ``LibPath::Path::ParsedPath``, and obtaining from it its attributes

## Source

```ruby
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

max_name_len	=	PATH_ATTRIBUTES.map { |sym| sym.to_s.size }.max_by { |s| s }
max_type_len	=	PATH_ATTRIBUTES.map { |sym| path.send(sym).class.to_s.size }.max_by { |s| s }

PATH_ATTRIBUTES.each do |attr|

	name	=	attr.to_s
	value	=	path.send(attr)
	type	=	value.class

	puts "\t\t#{name.to_s.rjust(max_name_len)} (#{type.to_s.rjust(max_type_len)}) : #{value}"
end
```

## Usage

When executed with the following command-line (on my machine):

```
./examples/path_from_arg0.rb .gitignore ../../../CLASP/CLASP.Ruby/trunk
```

The output is:

```
path obtained from '.gitignore' (with search directory '../../../CLASP/CLASP.Ruby/trunk'):

	path: /Users/matthewwilson/dev/freelibs/libpath/libpath.Ruby/trunk/.gitignore

	all attributes:
		                     given_path (  String) : .gitignore
		                  absolute_path (  String) : /Users/matthewwilson/dev/freelibs/libpath/libpath.Ruby/trunk/.gitignore
		                   compare_path (  String) : /Users/matthewwilson/dev/freelibs/libpath/libpath.Ruby/trunk/.gitignore
		                      directory (  String) : /Users/matthewwilson/dev/freelibs/libpath/libpath.Ruby/trunk/
		                 directory_path (  String) : /Users/matthewwilson/dev/freelibs/libpath/libpath.Ruby/trunk/
		                        dirname (  String) : /Users/matthewwilson/dev/freelibs/libpath/libpath.Ruby/trunk/
		                directory_parts (   Array) : ["/", "Users/", "matthewwilson/", "dev/", "freelibs/", "libpath/", "libpath.Ruby/", "trunk/"]
		                 file_full_name (  String) : .gitignore
		                       basename (  String) : .gitignore
		                 file_name_only (NilClass) : 
		                           stem (NilClass) : 
		                 file_extension (  String) : .gitignore
		                      extension (  String) : .gitignore
		               search_directory (  String) : /Users/matthewwilson/dev/freelibs/CLASP/CLASP.Ruby/trunk/
		           search_relative_path (  String) : ../../../libpath/libpath.Ruby/trunk/.gitignore
		 search_relative_directory_path (  String) : ../../../libpath/libpath.Ruby/trunk/
		search_relative_directory_parts (   Array) : ["../", "../", "../", "libpath/", "libpath.Ruby/", "trunk/"]
```


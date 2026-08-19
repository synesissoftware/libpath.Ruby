# ######################################################################## #
# File:     libpath-ruby.gemspec
#
# Purpose:  Gemspec for libpath.Ruby library
#
# Created:  8th January 2019
# Updated:  19th August 2026
#
# ######################################################################## #


$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'libpath/version'


Gem::Specification.new do |spec|

  spec.name         = 'libpath-ruby'
  spec.summary      = 'Path parsing library, for Ruby'
  spec.version      = LibPath::VERSION
  spec.description  = <<END_DESC
Path parsing library, for Ruby. libpath.Ruby is concerned entirely with
paths, as opposed to file-system entities. It classifies path form, parses
path strings, and rewrites/combines paths for Unix and Windows.
END_DESC

  spec.authors      = [
    'Matt Wilson',
  ]
  spec.email        = [
    'matthew@synesis.com.au',
  ]
  spec.homepage     = 'https://github.com/synesissoftware/libpath.Ruby'
  spec.license      = 'BSD-3-Clause'

  spec.required_ruby_version = [ '>= 2.0' ]

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/synesissoftware/libpath.Ruby/issues',
    'changelog_uri' => 'https://github.com/synesissoftware/libpath.Ruby/blob/master/CHANGES.md',
    'homepage_uri' => 'https://github.com/synesissoftware/libpath.Ruby',
    'source_code_uri' => 'https://github.com/synesissoftware/libpath.Ruby',
  }

  spec.files = Dir[
    'Rakefile',
    '{bin,examples,lib,man,spec,test}/**/*',
    'AUTHORS*',
    'CHANGES*',
    'CONTRIBUTING*',
    'EXAMPLES*',
    'FAQ*',
    'INSTALL*',
    'LICENSE*',
    'NEWS*',
    'README*',
    'SECURITY*',
    'TODO*',
  ] & `git ls-files -z`.split("\0")
  spec.files -= [
    '.ruby-version',
    'Gemfile.lock',
  ]

  spec.add_development_dependency "xqsr3", [ '>= 0.39.5', '< 1.0' ]
end


# ############################## end of file ############################# #

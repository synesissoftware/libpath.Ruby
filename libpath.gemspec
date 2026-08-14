# ######################################################################## #
# File:     libpath.gemspec
#
# Purpose:  Gemspec for libpath.Ruby library
#
# Created:  8th January 2019
# Updated:  15th August 2026
#
# ######################################################################## #


$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'libpath/version'


Gem::Specification.new do |spec|

  spec.name         = 'libpath-ruby'
  spec.version      = LibPath::VERSION
  spec.summary      = 'libpath.Ruby'
  spec.description  = <<END_DESC
Path parsing library for Ruby
END_DESC

  spec.authors      = [
    'Matt Wilson',
  ]
  spec.email        = [
    'matthew@synesis.com.au',
  ]
  spec.homepage     = 'https://github.com/synesissoftware/libpath.Ruby'
  spec.license      = 'BSD-3-Clause'

  spec.required_ruby_version = '>= 2.0'

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/synesissoftware/libpath.Ruby/issues',
    'changelog_uri' => 'https://github.com/synesissoftware/libpath.Ruby/blob/master/CHANGES.md',
    'homepage_uri' => 'https://github.com/synesissoftware/libpath.Ruby',
    'source_code_uri' => 'https://github.com/synesissoftware/libpath.Ruby',
  }

  spec.add_development_dependency "xqsr3", [ '>= 0.39.5', '< 1.0' ]

  spec.files        = Dir[ 'Rakefile', '{bin,examples,lib,man,spec,test}/**/*', 'README*', 'LICENSE*' ] & `git ls-files -z`.split("\0")
end


# ############################## end of file ############################# #

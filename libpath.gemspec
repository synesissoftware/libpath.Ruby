# gemspec for libpath

$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'libpath'

Gem::Specification.new do |spec|

	spec.name			=	'libpath-ruby'
	spec.version		=	LibPath::VERSION
	spec.date			=	Date.today.to_s
	spec.summary		=	'libpath.Ruby'
	spec.description	=	<<END_DESC
LibPath for Ruby
END_DESC
	spec.authors		=	[ 'Matt Wilson' ]
	spec.email			=	'matthew@synesis.com.au'
	spec.homepage		=	'http://libpath.org/'
	spec.license		=	'BSD-3-Clause'

	spec.add_development_dependency 'xqsr3', [ '>= 0.21.1', '< 1.0' ]

	spec.files		=	Dir[ 'Rakefile', '{bin,examples,lib,man,spec,test}/**/*', 'README*', 'LICENSE*' ] & `git ls-files -z`.split("\0")
end


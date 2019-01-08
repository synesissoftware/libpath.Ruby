# gemspec for libpath

$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'libpath'

Gem::Specification.new do |gs|

	gs.name			=	'libpath-ruby'
	gs.version		=	LibPath::VERSION
	gs.date			=	Date.today.to_s
	gs.summary		=	'libpath.Ruby'
	gs.description	=	<<END_DESC
LibPath for Ruby
END_DESC
	gs.authors		=	[ 'Matt Wilson' ]
	gs.email		=	'matthew@libpath.org'
	gs.files		=	Dir[ 'Rakefile', '{bin,examples,lib,man,spec,test}/**/*', 'README*', 'LICENSE*' ] & `git ls-files -z`.split("\0")
	gs.homepage		=	'http://libpath.org/'
	gs.license		=	'BSD-3-Clause'
end


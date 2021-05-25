$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'pronto/xmllint_version'
require 'rake'

Gem::Specification.new do |s|
  s.name = 'pronto-xmllint'
  s.version = Pronto::XMLLintVersion::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = 'Paulius Mazeika'
  s.summary = 'Pronto runner for XMLLint'

  s.required_ruby_version = '>= 2.0.0'
  s.rubygems_version = '2.5.1'

  s.files = FileList['README.md', 'lib/**/*']
  s.extra_rdoc_files = ['README.md']
  s.require_paths = ['lib']
  s.requirements << 'xmllint (in PATH)'

  s.add_dependency('pronto', '~> 0.11.0')
end

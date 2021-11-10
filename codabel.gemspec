$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'codabel/version'
require 'date'

Gem::Specification.new do |s|
  s.name        = 'codabel'
  s.version     = Codabel::VERSION
  s.date        = Date.today.to_s
  s.summary     = "Codabel, a generator of CODA financial files."
  s.description = "Codabel helps generating CODA files from structured information"
  s.authors     = ["Bernard Lambeau"]
  s.email       = 'bernard@flexio.app'
  s.files       = Dir['LICENSE.md','Gemfile','Rakefile','{bin,lib,tasks,examples}/**/*', 'README*'] & `git ls-files -z`.split("\0")
  s.homepage    = 'http://github.com/flexioapp/codabel'
  s.license     = 'MIT'

  s.add_development_dependency "rake", "~> 13"
  s.add_development_dependency "rspec", "~> 3.6"
end

require File.expand_path('../lib/tao/version', __FILE__)

Gem::Specification.new do |s|
  s.name       = 'taoism'
  s.version    = Tao::VERSION
  s.summary    = 'The Tao programming language'
  s.authors    = ['oneureka']
  s.files      = Dir['lib/**/*.rb']
  s.license    = 'MIT'
  s.executable = 'tao'
end

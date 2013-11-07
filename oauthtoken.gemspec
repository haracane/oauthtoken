# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oauth_token/version'

Gem::Specification.new do |spec|
  spec.name          = "oauthtoken"
  spec.version       = OAuthToken::VERSION
  spec.authors       = ["Kenji Hara"]
  spec.email         = ["haracane@gmail.com"]
  spec.description   = %q{Command to get OAuth token}
  spec.summary       = %q{Command to get OAuth token}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "oauth", "~> 0.4.7"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end

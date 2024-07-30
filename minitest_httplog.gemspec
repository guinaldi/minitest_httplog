require_relative 'lib/minitest_httplog/version'

Gem::Specification.new do |spec|
  spec.name          = "minitest_httplog"
  spec.version       = MinitestHttplog::VERSION
  spec.authors       = ["Guilherme Stefanelli"]
  spec.email         = ["guinaldister@gmail.com"]

  spec.summary       = %q{Detect unmocked HTTP requests in your tests}
  spec.description   = %q{Detect unmocked HTTP requests in your tests}
  spec.homepage      = "https://github.com/guinaldi/minitest_httplog"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/guinaldi/minitest_httplog"
  spec.metadata["changelog_uri"] = "https://github.com/guinaldi/minitest_httplog/changelog"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency "httplog"
  spec.add_dependency "minitest"
  # Development Dependencies
  spec.add_development_dependency "rails", ">= 6.0"
  spec.add_development_dependency "rack", ">= 2.0"
  spec.add_development_dependency "rake", ">= 12.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "byebug"
end

# frozen_string_literal: true

require "./lib/nanoc/tidy/version"
Gem::Specification.new do |gem|
  gem.name = "nanoc-tidy.rb"
  gem.authors = ["0x1eef"]
  gem.email = ["0x1eef@protonmail.com"]
  gem.homepage = "https://github.com/0x1eef/nanoc-tidy.rb#readme"
  gem.version = Nanoc::Tidy::VERSION
  gem.licenses = ["0BSD"]
  gem.files = `git ls-files`.split($/).reject { _1.start_with?(".") }
  gem.require_paths = ["lib"]
  gem.summary = "nanoc-tidy.rb = nanoc + tidy-html5"
  gem.description = gem.summary
  gem.add_runtime_dependency "ryo.rb", "~> 0.5"
  gem.add_runtime_dependency "test-cmd.rb", "~> 0.12.4"
  gem.add_development_dependency "yard", "~> 0.9"
  gem.add_development_dependency "redcarpet", "~> 3.5"
  gem.add_development_dependency "test-unit", "~> 3.6"
  gem.add_development_dependency "standard", "~> 1.13"
  gem.add_development_dependency "nanoc", "~> 4.12"
  gem.add_development_dependency "rack", "~> 3.0"
  gem.add_development_dependency "rackup", "~> 2.1"
  gem.add_development_dependency "ostruct", "~> 0.6"
end

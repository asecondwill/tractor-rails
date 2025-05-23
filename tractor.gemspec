# frozen_string_literal: true

require_relative "lib/tractor/version"

Gem::Specification.new do |spec|
  spec.name = "tractor"
  spec.version = Tractor::VERSION
  spec.authors = ["Will"]
  spec.email = ["will@kindleman.com.au"]

  spec.summary = "A basic Admin Helper"
  spec.description = "A very basic administraction helper"
  spec.homepage = "https://www.willbarker.dev"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/asecondwill/tractor-rails."
  spec.metadata["changelog_uri"] = "https://github.com/asecondwill/tractor-rails"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  # spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
  #   ls.readlines("\x0", chomp: true).reject do |f|
  #     (f == gemspec) ||
  #       f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
  #   end
  # end
  spec.files = Dir["app/**/*", "lib/**/*"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dartsass-rails"
  spec.add_dependency 'github-markup'
  spec.add_dependency "commonmarker"
  spec.add_dependency "name_of_person"
  spec.add_dependency "ransack"
  
  spec.add_dependency "acts_as_list"
  spec.add_dependency "ancestry"
  spec.add_dependency "shortcode"
  spec.add_dependency "marksmith"
  spec.add_dependency "bootstrap"


  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

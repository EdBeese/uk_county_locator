# frozen_string_literal: true

require_relative 'lib/uk_county_locator/version'

Gem::Specification.new do |spec|
  spec.name = 'uk_county_locator'
  spec.version = UkCountyLocator::VERSION
  spec.authors = ['Edward Beesley']
  spec.email = ['ed@homeflow.co.uk']

  spec.summary = 'A Ruby gem that stores encoded polygon data for UK counties, ' \
               'with the ability to return county information for given coordinates.'

  spec.homepage = 'https://github.com/EdBeese/uk_county_locator'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/EdBeese/uk_county_locator'
  spec.metadata['changelog_uri'] = 'https://github.com/EdBeese/uk_county_locator/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'geokit', '>= 1.0', '< 2.0'
  spec.add_dependency 'parallel', '>= 1.0', '< 2.0'
  spec.add_dependency 'polylines', '>= 0.3', '< 1.0'

  # spec.add_development_dependency 'pry', '~> 0.14.1'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

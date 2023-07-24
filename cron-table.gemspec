require_relative "lib/cron-table/version"

Gem::Specification.new do |spec|
  spec.name        = "cron-table"
  spec.version     = CronTable::VERSION
  spec.authors     = ["twratajczak"]
  spec.email       = ["twratajczak@gmail.com"]
  spec.homepage    = "https://github.com/cron-table/cron-table"
  spec.summary     = "Basic cron-like scheduling system for Rails"
  spec.description = "Simple system to schedule recurring jobs for Rails"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/cron-table/cron-table"
  spec.metadata["changelog_uri"] = "https://github.com/cron-table/cron-table/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", "~> 7.0"
  spec.add_development_dependency "mocha", "~> 1.0"
  spec.add_development_dependency "rufo", "~> 0.16"
end

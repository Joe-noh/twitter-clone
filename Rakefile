require 'rspec/core/rake_task'

task :default => :spec

desc "Run all specs in 'spec'"
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = %w(--color --format progress)
end
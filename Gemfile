# frozen_string_literal: true

source 'https://rubygems.org'

# rubocop:disable Bundler/DuplicatedGem
if ENV['RAILS_VERSION']
  gem 'rails', ENV['RAILS_VERSION']
elsif ENV['RAILS_BRANCH']
  gem 'rails', git: 'https://github.com/rails/rails.git', branch: ENV['RAILS_BRANCH']
end
# rubocop:enable Bundler/DuplicatedGem

gem 'rake'

group :test do
  gem 'coveralls', :require => false
  gem 'rspec', '~> 3.5.0'
  gem 'rubocop'
end

gemspec

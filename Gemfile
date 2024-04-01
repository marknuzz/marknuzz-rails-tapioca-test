# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby file: '.ruby-version'

gem 'dalli'
gem 'rails', '~> 7.0.8'
gem 'sorbet-runtime'
gem 'listen'
gem 'pg'

group :development, :dev_anon do
  gem 'sorbet', '>= 0.5.11305'
  gem 'tapioca', require: false
end

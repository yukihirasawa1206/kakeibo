source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.6', '>= 5.1.6.1'
gem 'pg'
gem 'oauth'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootstrap', '>= 4.1.2'
gem 'jquery-rails'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'httpclient'
gem 'toastr-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
	gem 'factory_bot_rails', '~> 4.10.0'
	gem 'pry-rails'
	gem 'rspec-rails', '~> 3.6.0'
	gem 'rspec-core'
	gem 'rspec_junit_formatter'
  gem 'webmock'
	gem 'dotenv-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
	gem 'spring-commands-rspec'
end

group :test do
	gem 'launchy'
  gem 'capybara', '~> 2.13'
	gem 'chromedriver-helper'
  gem 'selenium-webdriver'
end

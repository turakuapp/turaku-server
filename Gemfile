source 'https://rubygems.org'

ruby '2.6.3'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# A Ruby gem to load environment variables from `.env`. https://github.com/bkeepers/dotenv
#
# This needs to be kept near the top of the Gemfile to load environment variables as early as possible.
gem 'dotenv-rails', '~> 2.2', groups: %i[development test]

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'

# ActiveModel::Serializer implementation and Rails hooks
gem 'active_model_serializers', '~> 0.10.0'

# Flexible authentication solution for Rails with Warden.
gem 'devise', '~> 4.6'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Minimal authorization through OO design and pure Ruby classes
gem 'pundit', '~> 1.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Rack Middleware for handling Cross-Origin Resource Sharing (CORS), which makes cross-origin AJAX possible.
gem 'rack-cors', require: 'rack/cors'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'webpacker', '~> 2.0'

# An IRB alternative and runtime developer console.
gem 'pry-rails', '~> 0.3'

# Ruby implementation of GraphQL. http://graphql-ruby.org
gem 'graphql', '~> 1.8'

# Seedbank gives your seed data a little structure.
gem 'seedbank', '~> 0.4'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # A library for setting up Ruby objects as test data.
  gem 'factory_bot_rails', '~> 4.11'

  # A library for generating fake data such as names, addresses, and phone numbers.
  gem 'faker', '~> 1.7'
end

group :development do
  gem 'bullet', '~> 5.5'
  gem 'fuubar', '~> 2.2'

  # Mount the GraphiQL query editor in a Rails app.
  gem 'graphiql-rails', '~> 1.4'

  gem 'letter_opener', '~> 1.4'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'overcommit', '~> 0.38', require: false
  gem 'rspec-rails', '~> 3.5'
  gem 'rubocop', '~> 0.59', require: false
  gem 'spring', '~> 2.0'
  gem 'spring-watcher-listen', '~> 2.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'

  # Code coverage for Ruby.
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

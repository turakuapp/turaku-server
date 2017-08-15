source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'

# A Ruby gem to load environment variables from `.env`. https://github.com/bkeepers/dotenv
#
# This needs to be kept near the top of the Gemfile to load environment variables as early as possible.
gem 'dotenv-rails', '~> 2.2', groups: %i[development test]

# ActiveModel::Serializer implementation and Rails hooks
gem 'active_model_serializers', '~> 0.10.0'

# Ruby on Rails API documentation tool. https://github.com/Apipie/apipie-rails
gem 'apipie-rails', '~> 0.5'

# Flexible authentication solution for Rails with Warden.
gem 'devise', '~> 4.3'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Rack Middleware for handling Cross-Origin Resource Sharing (CORS), which makes cross-origin AJAX possible.
gem 'rack-cors', require: 'rack/cors'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # A library for setting up Ruby objects as test data.
  gem 'factory_girl_rails', '~> 4.8'

  # A library for generating fake data such as names, addresses, and phone numbers.
  gem 'faker', '~> 1.7'
end

group :development do
  gem 'bullet', '~> 5.5'
  gem 'fuubar', '~> 2.2'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'overcommit', '~> 0.38', require: false
  gem 'rspec-rails', '~> 3.5'
  gem 'rubocop', '~> 0.49', require: false
  gem 'spring', '~> 2.0'
  gem 'spring-watcher-listen', '~> 2.0'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

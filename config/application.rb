require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Turaku
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Configure CORS.
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '/api/v0/*', headers: :any, methods: %i[get post patch delete options]
        resource '/graphql', headers: :any, methods: %i[get post patch delete options]
        resource '/graphql/*', headers: :any, methods: %i[get post patch delete options]
      end
    end
  end
end

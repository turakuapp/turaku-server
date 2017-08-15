Apipie.configure do |config|
  config.app_name = 'Turaku'
  config.api_base_url = '/api/v0'
  config.doc_base_url = '/apipie'

  # Where is your API defined?
  config.api_controllers_matcher = Rails.root.join('app', 'controllers', 'v0', '**', '*.rb')
end

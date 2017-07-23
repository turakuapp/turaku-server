module Requests
  module JsonHelper
    def json
      JSON.parse(response.body)
    end
  end
end

# Include the JsonHelper for all request specs.
RSpec.configure do |config|
  config.include Requests::JsonHelper, type: :request
end

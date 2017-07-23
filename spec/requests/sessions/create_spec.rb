require 'rails_helper'

RSpec.describe 'Create session' do
  context 'when passed invalid parameters' do
    it 'returns AuthenticationFailureException' do
      post '/v0/sessions'
      expect(response).to have_http_status(422)
      expect(json['exception']).to eq('AuthenticationFailureException')
    end
  end

  context 'when passed a valid email and password' do
    let(:user) { create :user }

    it 'returns a new session' do
      expect do
        post '/v0/sessions', params: { email: user.email, password: 'password' }
      end.to change { Session.count }.by(1)

      expect(response).to be_success
      expect(json.keys).to include('name', 'token', 'last_used_at', 'created_at')

      # Compare the supplied token against the hashed token in database.
      expect(Digest::SHA256.hexdigest(json['token'])).to eq(Session.last.token_hash)
    end
  end
end

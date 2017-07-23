require 'rails_helper'

RSpec.describe 'Create session' do
  context 'when passed invalid parameters' do
    it 'returns AuthenticationFailureException' do
      post '/api/v0/session'
      expect(response).to have_http_status(422)
      expect(json['exception']).to eq('AuthenticationFailureException')
    end
  end

  context 'when passed a valid email and password' do
    let(:user) { create :user }

    it 'returns a new session' do
      expect do
        post '/api/v0/session', params: { email: user.email, password: 'password' }
      end.to change { Session.count }.by(1)

      expect(response).to be_success
      expect(json.keys).to include('id', 'name', 'token', 'last_used_at', 'created_at')
      last_session = Session.last
      expect(json['id']).to eq(last_session.id)

      # Compare the supplied token against the hashed token in database.
      expect(Digest::SHA256.hexdigest(json['token'])).to eq(last_session.token_hash)
    end
  end
end

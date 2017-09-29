require 'rails_helper'

RSpec.describe 'Create team' do
  let!(:session) { create :session, token: 'CREATE_TEAM' }
  let(:headers) { { authorization: 'Token CREATE_TEAM' } }

  context 'when passed invalid parameters' do
    it 'returns AuthenticationFailureException' do
      post '/api/v0/teams', params: { team: { name: 'lo' } }, headers: headers

      expect(response).to have_http_status(422)
      expect(json['exception']).to eq('ValidationFailureException')
    end
  end

  context 'when passed a valid name' do
    it 'returns a new session' do
      expect do
        post '/api/v0/teams', params: { team: { name: 'My Team' } }, headers: headers
      end.to change { Team.count }.by(1)

      expect(response).to be_success
      expect(json.keys).to include('id', 'name')
      last_team = Team.last
      expect(json['id']).to eq(last_team.id)
    end
  end
end

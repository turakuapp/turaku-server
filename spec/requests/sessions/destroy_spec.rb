require 'rails_helper'

RSpec.describe 'Destroy session' do
  let!(:session) { create :session, token_hash: Digest::SHA256.hexdigest('CURRENT_TOKEN') }
  let!(:another_session) { create :session, user: session.user, token_hash: Digest::SHA256.hexdigest('ANOTHER_TOKEN') }

  context 'when passed no parameter' do
    it 'destroys current session' do
      expect do
        delete '/api/v0/session', headers: { authorization: 'Token CURRENT_TOKEN' }
      end.to change { Session.count }.by(-1)

      expect(Session.find_by(id: session.id)).to eq(nil)
      expect(response).to be_success
    end
  end

  context 'when passed a session ID' do
    context 'when the session could not be found' do
      it 'raises exception' do
        expect do
          delete "/api/v0/sessions/#{session.id + another_session.id}", headers: { authorization: 'Token CURRENT_TOKEN' }
        end.to_not(change { Session.count })

        expect(response).to have_http_status(404)
      end
    end

    it 'destroys the mentioned session' do
      expect do
        delete "/api/v0/sessions/#{another_session.id}", headers: { authorization: 'Token CURRENT_TOKEN' }
      end.to change { Session.count }.by(-1)

      expect(Session.find_by(id: another_session.id)).to eq(nil)
      expect(response).to be_success
    end
  end
end

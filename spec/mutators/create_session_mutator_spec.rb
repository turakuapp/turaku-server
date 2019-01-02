require 'rails_helper'

RSpec.describe CreateSessionMutator do
  subject { described_class.new(params, {}) }

  let(:user) { create :user, :confirmed }
  let(:team_membership) { create :team_membership, user: user }
  let(:params) { { email: user.email, password: 'password' } }
  let(:service) { instance_double Sessions::CreateService }
  let(:session) { double 'Session' }

  describe '#create_session' do
    it 'calls Sessions::CreateService with correct values' do
      expect(Sessions::CreateService).to receive(:new).with(user).and_return(service)
      expect(service).to receive(:create).and_return(session)

      return_value = subject.create_session
      expect(return_value).to eq(session)
    end
  end

  describe '#valid?' do
    context 'when the credentials are incorrect' do
      let(:params) { { email: user.email, password: 'not_this_either' } }

      it 'returns false and sets appropriate error code' do
        expect(subject.valid?).to eq(false)
        expect(subject.error_codes).to contain_exactly('AuthenticationFailure')
      end
    end

    context 'when the user is not confirmed' do
      let(:user) { create :user }

      it 'returns false and sets appropriate error code' do
        expect(subject.valid?).to eq(false)
        expect(subject.error_codes).to contain_exactly('UnconfirmedEmail')
      end
    end
  end
end

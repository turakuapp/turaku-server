require 'rails_helper'

RSpec.describe Users::StandInService do
  subject { described_class.new(email) }
  let(:email) { Faker::Internet.email }

  RSpec.shared_examples 'when current user is different from requested user' do
    it 'returns an unpersisted user entry' do
      user = subject.compare(current_user)
      expect(user.id).to eq(nil)
    end

    context 'when the requested user does not exist' do
      it 'returns user with stand-in authentication salt' do
        user = subject.compare(current_user)
        expect(user.authentication_salt).to match(/[0-9a-f]{64}/)
      end
    end

    context 'when the requested user exists' do
      context 'when the requested user has authentication salt' do
        let!(:requested_user) { create :user, :registered, email: email }

        it 'returns user with true authentication salt' do
          user = subject.compare(current_user)
          expect(user.authentication_salt).to eq(requested_user.authentication_salt)
        end
      end

      context 'when the requested user does not have authentication salt' do
        let!(:requested_user) { create :user, email: email }

        it 'returns user with stand-in authentication salt' do
          user = subject.compare(current_user)
          expect(user.authentication_salt).not_to eq(requested_user.authentication_salt)
          expect(user.authentication_salt).to match(/[0-9a-f]{64}/)
        end
      end
    end
  end

  describe '#compare' do
    context 'when there is no signed in user' do
      let(:current_user) { nil }

      include_examples 'when current user is different from requested user'
    end

    context 'when the signed in user is not the requested user' do
      let(:current_user) { create :user, :confirmed }

      include_examples 'when current user is different from requested user'
    end

    context 'when the signed in user is the requested user' do
      let(:requested_user) { create :user, :confirmed, email: email }

      it 'returns the full persisted user entry' do
        user = subject.compare(requested_user)
        expect(user.id).to eq(requested_user.id)
        expect(user.authentication_salt).to eq(requested_user.authentication_salt)
      end
    end
  end
end

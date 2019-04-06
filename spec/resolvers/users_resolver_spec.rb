require 'rails_helper'

RSpec.describe UsersResolver do
  subject { described_class.new(context) }
  let(:email) { Faker::Internet.email }

  RSpec.shared_examples 'when the supplied email does not belong to current user' do
    it 'returns an unpersisted user entry' do
      user = subject.member(email)
      expect(user.id).to eq(nil)
    end

    context 'when a user with supplied email doest not exist' do
      it 'returns user with stand-in authentication salt' do
        user = subject.member(email)
        expect(user.authentication_salt).to match(/[0-9a-f]{64}/)
      end
    end

    context 'when a user with supplied email does exist' do
      context 'when the requested user has authentication salt' do
        let!(:requested_user) { create :user, :registered, email: email }

        it 'returns user with true authentication salt' do
          user = subject.member(email)
          expect(user.authentication_salt).to eq(requested_user.authentication_salt)
        end
      end

      context 'when the requested user does not have authentication salt' do
        let!(:requested_user) { create :user, email: email }

        it 'returns user with stand-in authentication salt' do
          user = subject.member(email)
          expect(user.authentication_salt).not_to eq(requested_user.authentication_salt)
          expect(user.authentication_salt).to match(/[0-9a-f]{64}/)
        end
      end
    end
  end

  describe '#compare' do
    context 'when there is no signed in user' do
      let(:context) { { current_user: nil } }

      include_examples 'when the supplied email does not belong to current user'
    end

    context 'when the signed in user is not the requested user' do
      let(:context) { { current_user: create(:user, :confirmed) } }

      include_examples 'when the supplied email does not belong to current user'
    end

    context 'when the signed in user is the requested user' do
      let(:requested_user) { create(:user, :confirmed, email: email) }
      let(:context) { { current_user: requested_user } }

      it 'returns the full persisted user entry' do
        user = subject.member(email)
        expect(user.id).to eq(requested_user.id)
        expect(user.authentication_salt).to eq(requested_user.authentication_salt)
      end
    end
  end
end

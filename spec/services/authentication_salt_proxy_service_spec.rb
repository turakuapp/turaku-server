require 'rails_helper'

RSpec.describe AuthenticationSaltProxyService do
  subject { described_class.new(email) }

  let(:email) { Faker::Internet.email }

  describe '#salt' do
    context 'when a user with supplied email doest not exist' do
      it 'returns a stand-in authentication salt' do
        expect(subject.salt).to match(/[0-9a-f]{64}/)
      end
    end

    context 'when supplied email matches an invited user' do
      it 'returns a stand-in authentication salt' do
        create(:user, email: email)
        expect(subject.salt).to match(/[0-9a-f]{64}/)
      end
    end

    context 'when supplied email matches a registered user' do
      it 'returns the authentication salt belonging to user' do
        requested_user = create(:user, :registered, email: email)
        expect(subject.salt).to eq(requested_user.authentication_salt)
      end
    end
  end
end

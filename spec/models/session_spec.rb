require 'rails_helper'

RSpec.describe Session, type: :model do
  subject { create :session }

  describe '#token' do
    context 'when a token is manually saved' do
      before do
        subject.token = 'TOKEN'
      end

      it 'returns the saved token' do
        expect(subject.token).to eq('TOKEN')
      end
    end

    context 'when there is no custom token' do
      it 'returns the stored hash of the token' do
        session = Session.find(subject.id)
        expect(session.token).to eq(subject.token_hash)
      end
    end
  end
end

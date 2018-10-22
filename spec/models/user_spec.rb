require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create :user }

  describe '#password_required?' do
    it 'returns the opposite of @skip_password' do
      expect(subject.password_required?).to eq(true)
      subject.skip_password = true
      expect(subject.password_required?).to eq(false)
    end
  end

  describe '#confirmation_required?' do
    context 'when user is confirmed' do
      subject { create :user, :confirmed }

      it 'returns false' do
        expect(subject.confirmation_required?).to eq(false)
      end
    end

    context 'when the user is not confirmed' do
      it 'returns the value of password_required?' do
        allow(subject).to receive(:password_required?).and_return(false)
        expect(subject.confirmation_required?).to eq(false)
        allow(subject).to receive(:password_required?).and_return(true)
        expect(subject.confirmation_required?).to eq(true)
      end
    end
  end
end

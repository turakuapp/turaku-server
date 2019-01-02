require 'rails_helper'
require 'mutator_helper'

RSpec.describe UpdateEntryMutator do
  subject { described_class.new(params, context) }

  let(:team_membership) { create :team_membership }
  let(:user) { team_membership.user }
  let(:entry) { create(:entry, team: team_membership.team, user: user) }
  let(:encrypted_data) { EncryptedDataHelper.fake }
  let(:params) { { id: entry.id, encrypted_data: encrypted_data, tag_ids: [] } }
  let(:context) { ContextHelper.authorized_context(user) }
  let(:service) { instance_double Entries::UpdateService }

  describe '#update_entry' do
    it 'calls Entries::UpdateService with correct values' do
      expect(Entries::UpdateService).to receive(:new).with(entry, encrypted_data, nil).and_return(service)
      expect(service).to receive(:update)

      subject.update_entry
    end
  end

  describe '#valid?' do
    context "when the user does not belong to the entry's team" do
      let(:user) { create :user, :confirmed }

      it 'returns false and sets appropriate error code' do
        expect(subject.valid?).to eq(false)
        expect(subject.error_codes).to contain_exactly('InvalidId')
      end
    end
  end
end

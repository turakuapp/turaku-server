require 'rails_helper'
require 'mutator_helper'

RSpec.describe CreateEntryMutator do
  subject { described_class.new(params, context) }

  let(:team_membership) { create :team_membership }
  let(:team) { team_membership.team }
  let(:user) { team_membership.user }
  let(:encrypted_data) { EncryptedDataHelper.fake }
  let(:params) { { team_id: team.id, encrypted_data: encrypted_data, tag_ids: [] } }
  let(:context) { ContextHelper.authorized_context(user) }
  let(:service) { instance_double Entries::CreateService }

  describe '#create_entry' do
    it 'calls Entries::CreateService with correct values' do
      expect(Entries::CreateService).to receive(:new).with(user, team, encrypted_data, nil).and_return(service)
      expect(service).to receive(:create)

      subject.create_entry
    end
  end

  describe '#valid?' do
    context 'when the user does not belong to team' do
      let(:user) { create :user, :confirmed }

      it 'returns false and sets appropriate error code' do
        expect(subject.valid?).to eq(false)
        expect(subject.error_codes).to contain_exactly('InvalidTeamId')
      end
    end
  end
end

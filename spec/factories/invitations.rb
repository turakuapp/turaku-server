FactoryGirl.define do
  factory :invitation do
    invitation_token 'INVITATION_TOKEN'
    invitation_created_at { Time.zone.now }
    invitation_sent_at { Time.zone.now }
    invited_user { create :user }
  end
end

class Types::TeamMember < Types::BaseObject
  field :id, ID, null: false
  field :email, String, null: false
  field :name, String, null: false
end

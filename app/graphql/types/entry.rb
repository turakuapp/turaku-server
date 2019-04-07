class Types::Entry < Types::BaseObject
  field :id, ID, null: false
  field :tag_ids, [ID], null: false
  field :encrypted_data, Types::EncryptedData, null: false
  field :user_id, ID, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

  def user_id
    object.user.id
  end

  def tag_ids
    object.tags.pluck(:id)
  end
end

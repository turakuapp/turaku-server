class SessionSerializer < ActiveModel::Serializer
  attributes :id, :name, :token, :last_used_at, :created_at
end

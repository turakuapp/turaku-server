class SessionSerializer < ActiveModel::Serializer
  attributes :name, :token, :last_used_at, :created_at
end

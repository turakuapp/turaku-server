class UserSerializer < ActiveModel::Serializer
  attributes :name, :encryption_salt
end

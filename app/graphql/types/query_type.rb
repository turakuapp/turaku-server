class Types::QueryType < Types::BaseObject
  field :user, Types::UserType, description: "Find a User with email address", null: true do
    argument :email, String, required: true
  end

  def user(**args)
    User.find_by(email: args[:email])
  end
end

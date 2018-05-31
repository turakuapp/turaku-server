class Types::QueryType < Types::BaseObject
  field :user, Types::User, description: "Find a User with email address", null: true do
    argument :email, String, required: true
  end

  def user(**args)
    user = User.find_by(email: args[:email])
    return user if user.present?
    User.new(email: args[:email], authentication_salt: Users::AuthenticationSaltService.new(email: args[:email]).salt)
  end
end

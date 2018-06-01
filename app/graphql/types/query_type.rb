class Types::QueryType < Types::BaseObject
  field :user, Types::User, description: "Find a User with email address", null: false do
    argument :email, String, required: true
  end

  def user(**args)
    user = User.find_by(email: args[:email])
    user.present? ? user : Users::StandInService.new(args[:email]).user
  end
end

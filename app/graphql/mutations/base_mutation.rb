class Mutations::BaseMutation < GraphQL::Schema::Mutation
  def current_user
    @current_user ||= context[:current_user]
  end
end

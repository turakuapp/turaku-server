class Mutations::CreateTags < GraphQL::Schema::Mutation
  argument :team_id, ID, required: true
  argument :tags, [Types::TagInput], required: true

  description "Create new tags."

  field :tags, [Types::Tag], null: false
  field :errors, [String], null: false

  def resolve(params)
    team = Team.find(params[:team_id])
    tag = Tag.new(team: team)

    tag_forms = params[:tags].map do |tag_params|
      Tags::CreateForm.new(tag).tap { |create_form| create_form.validate(tag_params) }
    end

    errors = tag_forms.map { |form| form.errors.messages.values }.flatten

    if errors.any?
      { tags: [], errors: errors }
    else
      { tags: tag_forms.map { |form| form.save }, errors: [] }
    end
  end
end

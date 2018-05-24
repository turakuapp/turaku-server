require_relative 'instrumentation/access_instrumentation'

GraphQL::Field.accepts_definitions(
  access: GraphQL::Define.assign_metadata_key(:access),
)

GraphQL::ObjectType.accepts_definitions(
  access: GraphQL::Define.assign_metadata_key(:access),
)

TurakuSchema = GraphQL::Schema.define do
  mutation(Types::MutationType)
  query(Types::QueryType)

  instrument :field, AccessInstrumentation.new(:current_entity)
end

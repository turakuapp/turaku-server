class ApplicationMutator
  include ActiveModel::Model

  attr_reader :context

  def initialize(attributes, context)
    @context = context
    assign_attributes(attributes)
  end

  def errors
    super.messages.values.flatten
  end
end

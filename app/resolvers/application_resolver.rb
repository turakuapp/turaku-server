class ApplicationResolver
  attr_reader :context

  def initialize(context)
    @context = context
  end

  def current_user
    context[:current_user]
  end
end

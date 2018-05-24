# https://gist.github.com/bgentry/da703027ed80002b9686f2f90ab3ab2c
class AccessInstrumentation
  attr_reader :current_user_key

  def initialize(current_user_key = :current_user)
    @current_user_key = current_user_key
  end

  def instrument(type, field)
    field = instrument_type(type, field) if type.metadata[:access]
    # only add the field access check if it exists and isn't identical to the
    # type access check:
    if field.metadata[:access] && field.metadata[:access] != type.metadata[:access]
      field = instrument_field(type, field)
    end

    field
  end

  protected

  def instrument_field(type, field)
    wrap_with_policy_check(
      field.metadata[:access],
      field,
      "You are not allowed to access #{field.name} on that #{type.name}",
    )
  end

  def instrument_type(type, field)
    wrap_with_policy_check(
      type.metadata[:access],
      field,
      "You are not allowed to access that #{type.name}",
    )
  end

  def wrap_with_policy_check(policy_action, field, msg)
    policy_method = :"#{policy_action}?"

    old_resolve_proc = field.resolve_proc
    new_resolve_proc = ->(obj, args, ctx) {
      policy = Pundit.policy!(ctx[current_user_key], obj)
      if policy.public_send(policy_method)
        old_resolve_proc.call(obj, args, ctx)
      else
        raise GraphQL::AnalysisError, msg
      end
    }

    # Return a copy of `field`, with a new resolve proc
    field.redefine do
      resolve(new_resolve_proc)
    end
  end
end

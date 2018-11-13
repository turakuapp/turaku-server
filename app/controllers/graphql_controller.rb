class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]

    context = {
      current_user: current_user,
      current_session: current_session,
      auth_token: auth_token
    }

    result = TurakuSchema.execute(query, variables: variables, context: context, operation_name: operation_name)

    render json: result
  end

  private

  def auth_token
    return if request.headers['Authorization'].blank?

    request.headers['Authorization'].split(' ').last
  end

  def current_session
    @current_session ||= Sessions::AuthenticationService.new(auth_token).authenticate
  end

  def current_user
    @current_user ||= current_session&.user
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end

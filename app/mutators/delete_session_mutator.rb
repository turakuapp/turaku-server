class DeleteSessionMutator < ApplicationMutator
  attr_accessor :id

  validate :user_must_own_session

  def user_must_own_session
    return if id.blank?
    return if session.blank?
    errors[:base] << 'InvalidId'
  end

  def session
    @session ||= begin
      if id.present?
        context[:current_user].sessions.find_by(id: id)
      else
        context[:current_session]
      end
    end
  end

  def delete_session
    Sessions::DestroyService.new(session).execute
  end
end

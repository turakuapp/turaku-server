module Sessions
  class DestroyForm< Reform::Form
    attr_writer :current_session

    property :id

    validate :session_must_be_present

    def session_must_be_present
      return if id.blank?
      return if supplied_session.present?
      errors[:base] << "InvalidId"
    end

    def destroy
      Sessions::DestroyService.new(session).execute
    end

    private

    def session
      @session ||= supplied_session || @current_session
    end

    def supplied_session
      return if id.blank?
      @supplied_session ||= current_user.sessions.find_by(id: id)
    end

    def current_user
      @current_user ||= @current_session.user
    end
  end
end

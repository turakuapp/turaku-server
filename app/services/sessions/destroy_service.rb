module Sessions
  class DestroyService
    def initialize(session)
      @session = session
    end

    def execute
      @session.destroy!
    end
  end
end

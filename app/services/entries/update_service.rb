module Entries
  # Updates an existing entry.
  class UpdateService
    # @param entry [Entry] Entry that is being updated.
    # @param encrypted_data [Hash] Entry data as an encrypted object.
    # @param tags [Array] List of tags for the entry.
    def initialize(entry, encrypted_data, tags)
      @entry = entry
      @encrypted_data = encrypted_data
      @tags = tags || []
    end

    # @return [Entry] Updated entry.
    def update
      @entry.update!(
        encrypted_data: @encrypted_data,
        tags: @tags
      )

      @entry
    end
  end
end

module Entries
  class UpdateForm < Reform::Form
    property :encrypted_data, validates: { encrypted_object: true }

    def save
      super
      model
    end
  end
end

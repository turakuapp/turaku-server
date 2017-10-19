module Teams
  class CreateForm < Reform::Form
    property :name, validates: { presence: true, length: { minimum: 3, maximum: 100 } }
    property :encrypted_password, virtual: true, validates: { presence: true }
  end
end

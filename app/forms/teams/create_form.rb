module Teams
  class CreateForm < Reform::Form
    property :name, validates: { presence: true, length: { minimum: 3, maximum: 100 } }
  end
end

json.entries @entries do |entry|
  json.(entry, :id, :user_id, :encrypted_data, :created_at, :updated_at)
  json.tags entry.tags, :id
end

json.(@session, :id, :name, :token, :last_used_at, :created_at)

json.user do
  json.(@session.user, :name, :encryption_salt)
end

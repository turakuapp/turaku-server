json.invited_user do
  json.(@invitation.invited_user, :id, :email)
end

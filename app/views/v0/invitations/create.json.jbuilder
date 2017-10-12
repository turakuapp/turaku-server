json.inviting_user do
  json.(@invitation.inviting_user, :id, :email)
end

json.invited_user do
  json.(@invitation.invited_user, :email)
end

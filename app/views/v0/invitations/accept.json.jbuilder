json.team do
  json.(@invitation.team, :id, :name)
  json.encrypted_password @invitation.team.team_memberships.find_by(user: current_user).encrypted_password
end

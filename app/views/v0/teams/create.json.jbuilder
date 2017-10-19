json.(@team, :id, :name)
json.encrypted_password @team.team_memberships.find_by(user: current_user).encrypted_password

json.(@session, :id, :name, :token, :last_used_at, :created_at)

json.user do
  json.(@session.user, :name, :encryption_salt)
end

json.teams @session.user.teams do |team|
  json.(team, :id, :name)
  json.encrypted_password team.team_memberships.find_by(user: @session.user).encrypted_password
end

json.incoming_invitations @session.user.incoming_invitations.pending do |invitation|
  json.(invitation, :id)

  json.team do
    json.(invitation.team, :id, :name)
  end

  json.inviting_user do
    json.(invitation.inviting_user, :email)
  end
end

class UsersResolver < ApplicationResolver
  def member(email)
    if current_user.present? && current_user.email == email
      current_user
    else
      user_with_public_fields(email)
    end
  end

  private

  def user_with_public_fields(email)
    user = User.find_by(email: email)
    salt = user&.authentication_salt || stand_in_authentication_salt(email)
    User.new(email: email, authentication_salt: salt)
  end

  def stand_in_authentication_salt(email)
    Digest::SHA2.hexdigest(email + Rails.application.secrets.authentication_salt[:hash_salt])
  end
end

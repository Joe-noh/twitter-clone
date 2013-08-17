Warden::Strategies.add :custom_auth_strategy do
  def valid?
    params['username'] && params['password']
  end

  def authenticate!
    user = User.where('name = ?', params['username']).first
    fail! 'Authentication Failed.' unless user

    if user.digest == SCrypt::Engine.hash_secret(params['password'], user.salt)
      success! user
    else
      fail! 'Authentication Failed.'
    end
  end
end

Warden::Manager.serialize_into_session do |user|
  user.name
end

Warden::Manager.serialize_from_session do |name|
  User.where('name = ?', name).first
end

helpers do
  def warden
    env['warden']
  end

  def logged_in?
    !warden.user.nil?
  end

  def login_user
    warden.user
  end
end
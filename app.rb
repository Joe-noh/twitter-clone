
before do
  pass if ['/signup', '/login', '/unauthenticated'].include? request.path_info
  request.path_info = '/' unless logged_in?
end

get '/' do
  if logged_in?
    @user = warden.user
    @statuses = Status.where(:user_id => @user.id).order(Sequel.desc :created_at).all
    slim :profile
  else
    redirect '/login'
  end
end

get '/login' do
  slim :login
end

post '/login' do
  warden.logout
  warden.authenticate!
  redirect '/'
end

post '/unauthenticated' do
  @error = warden.message || 'Authentication Failed.'
  slim :login
end

get '/logout' do
  warden.logout
  redirect '/login'
end


get '/signup' do
  slim :signup
end

post '/signup' do
  if params[:password] != params[:confirmation]
    @error = "'Password' and 'Password Confirmation' are different."
    slim :signup
  end

  salt   = SCrypt::Engine.generate_salt
  digest = SCrypt::Engine.hash_secret(params[:password], salt)

  user = User.new(:name   => params[:username],
                  :digest => digest,
                  :salt   => salt)

  if user.valid?
    user.save
    redirect '/login'
  else
    @error = user.errors.full_messages.first
    slim :signup
  end
end


get '/user/:name' do
  @user = User.where(:name => name).first
  @statuses = Status.where(:name => @user.name).order(Sequel.desc :created_at).all
  slim :profile
end

get '/user/edit' do
  slim :profile_edit
end

post '/user/edit' do
  User.where(:name => warden.user.name).update(:self_introduction => params[:self_introduction])
  redirect '/'
end


post '/status/new' do
  status = Status.new(:text => params[:status_text])
  warden.user.add_status status

  redirect '/'
end

get '/status/:id' do
  @status = Status.where(:id => id).first
  slim :status_show
end

not_found do
  redirect '/'
end

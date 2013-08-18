
before do
  pass if ['/signup', '/login', '/unauthenticated'].include? request.path_info
  request.path_info = '/' unless logged_in?
end

get '/' do
  if logged_in?
    slim :home
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
  @errors = warden.message || 'Authentication Failed.'
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
  redirect 'signup' unless params[:password] == params[:confirmation]

  salt   = SCrypt::Engine.generate_salt
  digest = SCrypt::Engine.hash_secret(params[:password], salt)

  User.create(:name   => params[:username],
              :digest => digest,
              :salt   => salt)
  redirect '/login'
end


get '/user/:name' do
  'user profile page'
end

get '/user/:name/edit' do
  'confirm that :name is warden.user.name'
  'edit form'
end

post '/user/:name/edit' do
  'confirm that :name is warden.user.name'
  'edit user profile'
end


post '/status/new' do
  'make new status'
end

get '/status/:id' do
  'show the status'
end

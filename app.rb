
before do
  pass if ['/user/new', '/login', '/unauthenticated'].include? request.path_info
  request.path_info = '/' unless logged_in?
end

get '/' do
  if logged_in?
    slim :home
  else
    slim :login
  end
end

get '/login' do
  slim :login
end

post '/login' do
  warden.authenticate!
  redirect '/'
end

post '/unauthenticated' do
  @error = warden.error
  slim :login
end

get '/logout' do
  warden.logout
  slim :login
end


get '/user/new' do
  'registration form'
end

post '/user/new' do
  'make new user'
end


get '/user/profile/:name' do
  'user profile page'
end

get '/user/profile/:name/edit' do
  'confirm that :name is warden.user.name'
  'edit form'
end

post '/user/profile/:name/edit' do
  'confirm that :name is warden.user.name'
  'edit user profile'
end


post '/status/new' do
  'make new status'
end

get '/status/:id' do
  'show the status'
end

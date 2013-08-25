
before do
  pass if ['/signup', '/login', '/unauthenticated'].include? request.path_info
  request.path_info = '/' unless logged_in?
end

get '/' do
  if logged_in?
    redirect "/user/#{warden.user.name}"
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
  @flash = {:danger => warden.message || 'Authentication Failed.'}
  slim :login
end

get '/logout' do
  warden.logout
  slim :login
end


get '/signup' do
  slim :login, :locals => {:active_tab => :signup}
end

post '/signup' do
  if params[:password] != params[:confirmation]
    @flash = {:danger => "'Password' and 'Password Confirmation' are different."}
    return slim :login, :locals => {:active_tab => :signup}
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
    @flash = {:danger => user.errors.full_messages.first}
    slim :login, :locals => {:active_tab => :signup}
  end
end


STATUSES_PER_PAGE = 10
get '/user/:name' do
  @user = User.where(:name => params[:name]).first
  return status 404 if @user.nil?

  page = (params[:p] || 1).to_i

  if params[:name] == warden.user.name
    statuses  = @user.timeline
    @statuses = statuses[STATUSES_PER_PAGE*(page-1), STATUSES_PER_PAGE]
  else
    statuses  = Status.where(:user_id => @user.id).order(Sequel.desc :created_at)
    @statuses = statuses.limit STATUSES_PER_PAGE, STATUSES_PER_PAGE*(page-1)
  end

  slim :profile, :locals => {:page     => page,
                             :page_max => (statuses.count/STATUSES_PER_PAGE.to_f).ceil}
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
  @status = Status.where(:id => params[:id]).first
  slim :status_show
end


not_found do
  redirect '/'  # TODO: prepare 404 page
end

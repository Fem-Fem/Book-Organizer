class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end


  get '/' do
    if session[:user_id] == nil
      erb :homepage
    else
      redirect to '/allbooks'
    end
  end

  get '/signup' do
    if session[:user_id] == nil
      erb :signup
    else
      redirect to '/allbooks'
    end
  end

  post '/signup' do
    if params["username"] == "" || params["password"] == ""
      redirect to '/signup'
    else
      @owner = Owner.create(params["username"], params["password"])
      session[:user_id] == @owner.id
      redirect to '/allbooks'
    end
  end

  get '/login' do
    if session[:user_id] == nil
      erb :login
    else
      redirect to '/allbooks'
    end
  end

  post '/login' do
    if params["username"] == "" || params["password"] == ""
      redirect to '/login'
    else
      #password?
      @owner = Owner.find_by(username: params["username"])
      session[:user_id] == @owner.id
      redirect to '/allbooks'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session[:user_id].delete
      redirect to '/'
    else
      redirect to '/login'
    end
  end

end

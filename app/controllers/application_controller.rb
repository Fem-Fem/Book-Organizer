class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end


  get '/' do
    erb: homepage
  end

  get '/signup' do
    erb :signup
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
    erb :login
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


end

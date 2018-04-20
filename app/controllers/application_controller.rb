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
      redirect to '/books'
    end
  end

  get '/signup' do
    if session[:user_id] == nil
      erb :signup
    else
      redirect to '/books'
    end
  end

  post '/signup' do
    if params["username"] == "" || params["password"] == ""
      redirect to '/signup'
    else
      @owner = Owner.create(:username => params["username"],:password => params["password"])
      session[:user_id] = @owner.id
      redirect to '/books'
    end
  end

  get '/login' do
    if session[:user_id] == nil
      erb :login
    else
      redirect to '/books'
    end
  end

  post '/login' do
    if params["username"] == "" || params["password"] == ""
      redirect to '/login'
    else
      @owner = Owner.find_by(username: params["username"])
      session[:user_id] = @owner.id
      redirect to '/books'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session[:user_id] = nil
    end
    redirect to '/'
  end

  get '/books' do
    if session[:user_id] == nil
      redirect to '/'
    else
      @books = Book.all
      erb :books
    end
  end

  get '/books/new' do
    if session[:user_id] == nil
      redirect to '/'
    else
      erb :createbook
    end
  end

  post '/books/new' do
    @owner = Owner.find(session[:user_id])
    @owner.books << Book.create(params)
    redirect to '/books'
  end

  get '/books/:id' do
    @book = Book.find(params["id"])
    if session[:user_id] == nil
      redirect to '/'
    else
      erb :specificbook
    end
  end

  get '/book/<%= params[:id]%>/edit' do
    if params[:id].user_id != @user.id
      redirect to '/books'
    else
      erb :editbook
    end
  end

  patch '/book/<%= params[:id]%>/edit' do
    @book = Book.find(params["id"])
    @book.title = params["title"]
    @book.genre = params["genre"]
  end

  delete '/book/:id/delete' do
    if params[:id].user_id != @user.id
      redirect to '/books'
    else
      #delete book
      Book.delete(params[:id])
      redirect to '/books'
    end
  end

end

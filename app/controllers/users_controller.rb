class UsersController < ApplicationController


  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:user].find{|requirement, value| value == ""}
      redirect '/signup'
    end

    @user = User.create(params[:user])
    session[:user_id] = @user.id
    redirect '/tweets'

  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/login'
    end
  end

  post '/login' do
    @user = User.find_by(email: params[:user][:email])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end


  get '/logout' do
    session.clear
    redirect '/'
  end

end

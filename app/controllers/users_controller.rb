require './config/environment'
class UsersController < ApplicationController

    get '/signup' do
        erb :'users/new'
    end

    post '/signup' do
        if params[:username] == "" || params[:password] == "" || params[:email] == ""
            redirect to '/signup'
          else
            @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
            session[:user_id] = @user.id
            redirect '/'
          end
    end

    get '/login' do
        if !session[:user_id]
            erb :'users/login'
        else
            redirect '/'
        end
    end
    post '/login' do
        user = User.find_by(:username => params[:username] ||params[:email])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect '/'
        end
    end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
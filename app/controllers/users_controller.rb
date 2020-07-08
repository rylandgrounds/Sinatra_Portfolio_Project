require './config/environment'
class UsersController < ApplicationController

    get '/signup' do
        erb :'users/new'
    end

    post '/signup' do
        if params[:username] == "" || params[:password] == ""
            redirect to '/signup'
        elsif  User.find_by(username: params[:username])
            redirect to '/signup'
        else
            user = User.create(:username => params[:username], :password => params[:password])
            session[:user_id] = user.id
            erb :welcome
          end
    end
    
    get '/user/animes' do
        redirect_if_not_logged_in
        erb :'users/show'
    end

    get '/login' do
        if !session[:user_id]
            erb :'users/login'
        else
            erb :'users/show'
        end
    end
    
    post '/login' do
       login(params[:username], params[:password])
    end

  get '/logout' do
    redirect_if_not_logged_in
   logout!
  end
end
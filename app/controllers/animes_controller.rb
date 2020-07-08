require './config/environment'
class AnimesController < ApplicationController
   
    post '/search' do
        redirect_if_not_logged_in
       if  params[:anime_name].size >=  3
            name = params[:anime_name].strip.downcase
            @results = edit_data(name)
            erb  :'animes/new'
       else
            redirect '/'
        end
    end

   

    post '/new' do
        redirect_if_not_logged_in
        name = params[:anime_name].strip.downcase
        @results = edit_data(name)
        @results.each do |result| 
            title = result["title"]
                if title.strip.downcase == name.strip.downcase
                new_anime = current_user.animes.build(:mal_id => result.mal_id, :title => result.title, :rated => result.rated, :synopsis => result.synopsis, :url => result.url, :score => result.score, :user_notes  => 'No notes', :image_url => result.image_url, :airing=> result.airing, :episodes => result.episodes)
                new_anime.save 
                redirect '/user/animes'
            end
        end
       redirect '/user/animes'
    end

    get '/animes/:id/edit' do
        redirect_if_not_found
            erb :'animes/edit'
      end
      
      get '/animes/:id' do
        redirect_if_not_found
        erb :'animes/show'
        end

      patch '/animes/:id' do 
        redirect_if_not_found
        @anime.user_notes = params[:user_notes]
        @anime.save
        redirect '/'
      end
      
      delete '/animes/:id' do
        redirect_if_not_found
        @anime.delete
        redirect '/'
      end
      
end
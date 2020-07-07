require './config/environment'
class AnimesController < ApplicationController
   
    post '/search' do
        redirect_if_not_logged_in
       if  params[:anime_name].size >=  3
            name = params[:anime_name].strip.downcase
            @results = edit_data(name)
            erb  :'animes/show'
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
                if title.strip.downcase == name.strip.downcase && !current_user.animes.find_by(title: result.title)
                new_anime = current_user.animes.build(:mal_id => result.mal_id, :title => result.title, :rated => result.rated, :synopsis => result.synopsis, :url => result.url, :score => result.score, :user_notes  => 'No notes', :image_url => result.image_url, :airing=> result.airing, :episodes => result.episodes)
                new_anime.save 
            end
        end
        erb :'users/show'
    end

    get '/animes/:id/edit' do
        redirect_if_not_logged_in
        @anime = Anime.find_by(id: params[:id], user_id: current_user.id)
        erb :'animes/edit'
      end


      patch '/animes/:id' do 
        redirect_if_not_logged_in
        @anime = Anime.find_by(id: params[:id])
        @anime.user_notes = params[:user_notes]
        @anime.save
        erb :'users/show'
      end
      
      delete '/animes/:id' do
        redirect_if_not_logged_in
        @anime = Anime.find_by(id: params[:id], user_id: current_user.id)
        @anime.delete
        erb :'users/show'
      end

end
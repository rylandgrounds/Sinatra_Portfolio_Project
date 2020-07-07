class CreateAnimes < ActiveRecord::Migration
  def change
    create_table :animes do |t|
      t.string :mal_id
      t.string :title
      t.string :rated
      t.string :synopsis
      t.string :url
      t.integer :score
      t.integer :user_id
      t.string :image_url
      t.string  :airing
      t.integer :episodes
    end
  end
end

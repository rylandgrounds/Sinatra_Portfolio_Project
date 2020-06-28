class CreateMedias < ActiveRecord::Migration
  def change
    create_table :medias do |t|
      t.string :mal_id
      t.string :title
      t.string :rated
      t.string :synopsis
      t.string :url
      t.integer :score
      t.integer :user_id
    end
  end
end

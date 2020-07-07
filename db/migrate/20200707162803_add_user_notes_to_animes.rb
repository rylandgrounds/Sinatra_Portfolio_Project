class AddUserNotesToAnimes < ActiveRecord::Migration
  def change
    add_column :animes, :user_notes, :string
  end
end

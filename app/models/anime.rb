class Anime < ActiveRecord::Base
    belongs_to :user
    validates :title, uniqueness: {scope: :user_id, message:"Only one per user"} 
end
class Location < ApplicationRecord
  belongs_to :game
  #current owner set through player_id

  has_many :character_locations
  has_many :characters, through: :character_locations

end

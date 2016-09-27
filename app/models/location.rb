class Location < ApplicationRecord
  belongs_to :game
  #current owner set through player_id

  has_many :character_locations
  has_many :characters, through: :character_locations

  def player_in_control
    Player.find(self.controlled_by)
  end

end

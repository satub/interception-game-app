class Game < ApplicationRecord
  has_many :game_players
  has_many :players, through: :game_players
  has_many :teams, through: :players
  
  has_one :map
end

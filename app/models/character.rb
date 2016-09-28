class Character < ApplicationRecord
  belongs_to :player

  has_many :character_locations
  has_many :locations, through: :character_locations

  has_many :game_characters
  has_many :games, through: :game_characters
  
  enum role: [:elite, :loose_cannon]

  validates :name, presence: true
end

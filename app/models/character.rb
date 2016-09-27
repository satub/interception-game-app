class Character < ApplicationRecord
  belongs_to :player

  has_many :character_locations
  has_many :locations, through: :character_locations

  enum role: [:elite, :loose_cannon]
end

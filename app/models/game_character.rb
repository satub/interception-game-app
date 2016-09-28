class GameCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :game

  validates :troops, numericality: {only_integer: true, greater_than_or_equal_to: 0}


end

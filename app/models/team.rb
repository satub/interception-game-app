class Team < ApplicationRecord
  belongs_to :player
  # belongs_to :game

  has_many :characters
end

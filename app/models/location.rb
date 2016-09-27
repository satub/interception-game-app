class Location < ApplicationRecord
  belongs_to :map
  belongs_to :player ## set for early testing purposes, should be team, not player
  # belongs_to :team

  has_many :actions
  has_many :turns, through: :actions
  has_many :characters, through: :actions
end

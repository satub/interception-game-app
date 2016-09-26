class Map < ApplicationRecord
  belongs_to :game
  has_many :locations
end

class CharacterLocation < ApplicationRecord
  belongs_to :character
  belongs_to :location

  validates :message, presence: true
  
end

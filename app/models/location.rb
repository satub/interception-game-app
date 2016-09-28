class Location < ApplicationRecord
  belongs_to :game

  has_many :character_locations
  has_many :characters, through: :character_locations

  validates :content, presence: true
  
  accepts_nested_attributes_for :characters
  accepts_nested_attributes_for :character_locations

  def player_in_control
    Player.find(self.controlled_by)
  end

  def characters_attributes=(character_attributes)
    # self.save
      # binding.pry
    character_attributes.values.each do |character_attribute|
      # binding.pry
      # find character and update it
    end
  end

  def character_locations_attributes=(character_location_attributes)
    # binding.pry
      character_location_attributes.values.each do |character_location_attribute|
      CharacterLocation.create(character_location_attribute.merge(location_id: self.id, success: true))
    end
  end


end

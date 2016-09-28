class Location < ApplicationRecord
  belongs_to :game

  has_many :character_locations
  has_many :characters, through: :character_locations

  accepts_nested_attributes_for :characters
  accepts_nested_attributes_for :character_locations

  def player_in_control
    Player.find(self.controlled_by)
  end

  def characters_attributes=(character_attributes)
    # self.save
      binding.pry
    character_attributes.values.each do |character_attribute|
      binding.pry
      # find character and update it
    end
  end

  def character_locations_attributes=(character_location_attributes)
    binding.pry
    # self.locations.each do |location|
    #   location_attributes.values.each do |location_attribute|
      # #update location if stuff fits
    #   # end
    # end
  end


end

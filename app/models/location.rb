class Location < ApplicationRecord
  belongs_to :game

  validates :content, presence: true

  has_many :character_locations
  has_many :characters, through: :character_locations
  validates_associated :character_locations

  accepts_nested_attributes_for :characters
  accepts_nested_attributes_for :character_locations

  def player_in_control
    Player.find(self.controlled_by).alias
  end


  def history
    self.character_locations.order(id: :desc)
  end

  ##This might not be needed at all, remove if this can be done with model methods instead :P
  def characters_attributes=(character_attributes)
    character_attributes.values.each do |character_attribute|
    end
  end


  def character_locations_attributes=(character_location_attributes)
    ## create charlocation, check for success, update success field, and other models dependent on it by calling model methods
    # binding.pry
      character_location_attributes.values.each do |character_location_attribute|
        cl = CharacterLocation.new(character_location_attribute.merge(location_id: self.id, success: true))
          if cl.save
            cg = cl.character.game_characters.detect{|gc| gc.game_id == self.game_id}
            troops_left = cg.troops - character_location_attribute[:troops_sent].to_i
            cg.update(troops: troops_left)
          else
            errors.add(:character_location, cl.errors.messages[:troops_sent])
          end
    end
  end


end

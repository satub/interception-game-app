class Location < ApplicationRecord
  belongs_to :game

  validates :content, presence: true

  has_many :character_locations
  has_many :characters, through: :character_locations
  validates_associated :character_locations

  accepts_nested_attributes_for :character_locations

  def player_in_control
    Player.find(self.controlled_by).alias
  end

  def history
    self.character_locations.order(id: :desc)
  end


  def take_over?
    binding.pry
  end

  def set_defense
    binding.pry
  end


  def character_locations_attributes=(character_location_attributes)
    ## create charlocation, check for success, update success field, and other models dependent on it by calling model methods
    # binding.pry
      character_location_attributes.values.each do |character_location_attribute|
        cl = CharacterLocation.new(character_location_attribute.merge(location_id: self.id))
          if cl.save
            cg = cl.character.game_characters.detect{|gc| gc.game_id == self.game_id}
            troops_left = cg.troops - character_location_attribute[:troops_sent].to_i
            cg.update(troops: troops_left)
            new_defense = cl.location.defense - cl.troops_sent
            cl.location.update(defense: new_defense.abs)
          else
            errors.add(:character_location, cl.errors.messages[:troops_sent])
          end
    end
  end


end

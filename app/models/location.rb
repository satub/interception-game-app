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

  def set_defense(troops_sent)
    new_defense = self.defense - troops_sent
    self.update(defense: new_defense.abs)
  end

  def character_locations_attributes=(character_location_attributes)
    character_location_attributes.values.each do |character_location_attribute|
      cl = CharacterLocation.create(character_location_attribute.merge(location_id: self.id))
      cg = cl.character.game_characters.detect{|gc| gc.game_id == self.game_id}
      cg.troops_left(cl.troops_sent)
      self.set_defense(cl.troops_sent)
    end
  end


end

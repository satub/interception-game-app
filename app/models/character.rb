class Character < ApplicationRecord
  belongs_to :player
  
  has_many :character_locations
  has_many :locations, through: :character_locations
  has_many :game_characters
  has_many :games, through: :game_characters

  enum role: [:elite, :loose_cannon]
  accepts_nested_attributes_for :game_characters

  validates :name, presence: true
  validate :unique_for_this_player, if: :player_id


  def game_characters_attributes=(game_character_attributes)
    game_character_attributes.values.each do |gc_attrib|
      default_troops = 1000  #this will be decided by game size
      gc_attrib[:character_id].each_with_index do |char, i|
        GameCharacter.find_or_create_by(game_id: gc_attrib[:game_id], character_id: gc_attrib[:character_id][i], troops: default_troops) unless i == 0
      end
    end
  end

  def self.who_am_i(id)
    Character.find(id).name
  end

  def self.active_characters(game, player)
     self.joins(:games, :player).where("games.id = ? AND players.id = ?", game.id, player.id)
  end

  ###Variable character levels are not supported atm, but this is set ready for that
  def attack(troops)
    troops + self.level * troops
  end

  ###Custom validation
  def unique_for_this_player
    if !self.player.characters.empty?
      if self.player.characters.detect {|character| character.name == self.name}
        errors.add(:name, "not unique. All your character names need to be unique.")
      end
    end
  end


end

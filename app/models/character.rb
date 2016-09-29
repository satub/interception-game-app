class Character < ApplicationRecord
  belongs_to :player

  has_many :character_locations
  has_many :locations, through: :character_locations

  has_many :game_characters
  has_many :games, through: :game_characters

  enum role: [:elite, :loose_cannon]

  accepts_nested_attributes_for :game_characters

  validates :name, presence: true
  validate :unique_for_this_player

  def self.active_characters(game, player)
     self.joins(:games, :player).where("games.id = ? AND players.id = ?", game.id, player.id)
  end

  def unique_for_this_player
    if !self.player.characters.empty?
      if self.player.characters.detect {|character| character.name == self.name}
        errors.add(:name, "not unique. All your character names need to be unique.")
      end
    end
  end


end

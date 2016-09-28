class CharacterLocation < ApplicationRecord
  belongs_to :character
  belongs_to :location

  validates :message, presence: true
  validates :troops_sent, numericality: {only_integer: true}

  validate :has_enough_troops

  def has_enough_troops
    binding.pry
    game = self.location.game_id
    status = self.character.game_characters.detect {|game_character| game_character.game_id = game }
    if status.troops < self.troops_sent
      errors.add(troops_sent: "You can't send more troops than you have available")
    end
  end
end

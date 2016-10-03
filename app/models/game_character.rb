class GameCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :game

  def troops_left(troops_sent)
    self.troops - troops_sent < 0 ? troops_left = 0 : troops_left = self.troops - troops_sent
    self.update(troops: troops_left)
  end

  def self.character_in_use?(game_id, character_id)  #returns the record if yes, nil if not
    GameCharacter.find_by(game_id: game_id, character_id: character_id)
  end

end

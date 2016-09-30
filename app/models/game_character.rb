class GameCharacter < ApplicationRecord
  belongs_to :character
  belongs_to :game

  # validates :troops, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  # replace this with a custom method, not validation

  def troops_left(troops_sent)
    self.troops - troops_sent < 0 ? troops_left = 0 : troops_left = self.troops - troops_sent
    self.update(troops: troops_left)
  end


end

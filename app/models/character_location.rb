class CharacterLocation < ApplicationRecord
  belongs_to :character
  belongs_to :location

  validates :message, presence: true
  validates :troops_sent, numericality: {only_integer: true, allow_nil: true}


  def has_enough_troops  ### this needs a function that sets the attempt failed or succeeded, not a validation
    binding.pry
    game = self.location.game_id
    status = self.character.game_characters.detect {|game_character| game_character.game_id == game }
    if self.troops_sent.nil?
      #no troops sent, that's ok by this validation
    elsif status.troops < self.troops_sent
      self.location.errors.add(:troops_sent, "You can't send more troops than you have available")
    end
  end


  def valid_action?
  end

  def successful_action?
  end

  def log_it
  end


end

class Game < ApplicationRecord
  has_many :game_players
  has_many :players, through: :game_players
  has_many :locations

  has_many :game_characters
  has_many :characters, through: :game_characters

  validates :title, presence: true
  validates :map_size, numericality: {only_integer: true}, inclusion: {in: (4..20)}

  ###Custom functions:
  ###no more than (2) characters per player per game (would be nicer if this was dependent of map_size)
  ###be able to tell when a game is over
  ###be able to shut off joining in function after 2 players in a game

  def self.pending_games
    Game.where(status: "pending").order(:id)
  end

  def joinable?
    self.status == "pending"
  end

  def launchable?
    self.players.size > 1
  end
  #
  # def full_game?
  #   binding.pry
  #   Game.joins(:game_characters)
  # end
  def whose_turn_is_it_anyway
    yours = self.players.detect{|player| player.id == self.turn}
    yours.alias unless yours.nil?
  end

  def game_over?
  end

  def no_locations?
    self.locations.empty?
  end

  def assign_locations(player_array)
    if player_array.size == 1
      self.map_size.times do
        location = Location.create(game_id: self.id, controlled_by: player_array[0].id, content: Faker::ChuckNorris.fact)
      end
    else
      i = 0
      until i >= self.map_size/2
        self.locations[i].update(controlled_by: player_array[1].id, content: Faker::StarWars.quote)
        i += 1
      end
    end
  end


end

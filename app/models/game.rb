class Game < ApplicationRecord
  has_many :locations
  has_many :game_players
  has_many :players, through: :game_players
  has_many :game_characters
  has_many :characters, through: :game_characters

  validates :title, presence: true
  validates :map_size, numericality: {only_integer: true}, inclusion: {in: (4..20)}

  def self.pending_games
    Game.where(status: "pending").order(:id)
  end

  def self.my_games(player)
    self.joins(:players).where("players.id = ?", player.id)
  end

  def no_more_characters?(player)
    self.class.joins(:characters).where('characters.player_id = ? AND game_characters.game_id = ?', player.id, self.id).size >= 2
  end

  def joinable?
    self.status == "pending"
  end

  def launchable?
    self.players.size > 1 && self.status == "pending"
  end

  def whose_turn_is_it_anyway
    theirs = self.players.detect{|player| player.id == self.turn}
    theirs.alias unless theirs.nil?
  end

  def switch_turn
    next_player = self.players.detect {|player| player.id != self.turn }  ##note: currently works only with 2-player game
    self.update(turn: next_player.id)
  end

  def game_over?
    self.players.collect {|player| self.locations.all?{|location| location.controlled_by == player.id}}.any?
  end

  def winner_id
    self.locations.first.controlled_by if game_over?
  end

  def no_locations?
    self.locations.empty?
  end

  def assign_locations(player_array)  ##works only for 2-players atm
    if player_array.size == 1
      self.map_size.times do
        location = Location.create(game_id: self.id, controlled_by: player_array[0].id, content: Faker::ChuckNorris.fact, defense: rand(50..200))
      end
    else
      i = 0
      until i >= self.map_size/2
        self.locations[i].update(controlled_by: player_array[1].id, content: Faker::StarWars.quote, defense: rand(50..200))
        i += 1
      end
    end
  end

  def configure_characters
    start_with = self.map_size/2 * 500
    self.game_characters.each{|character| character.update(troops: start_with * character.level)}
  end


end

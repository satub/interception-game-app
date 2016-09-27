class Game < ApplicationRecord
  has_many :game_players
  has_many :players, through: :game_players
  has_many :locations



  def no_locations?
    self.locations.empty?
  end

  def assign_locations(player_array)
    if player_array.size == 1
      self.map_size.times do
        location = Location.create(game_id: self.id, controlled_by: player_array[0].id, content: Faker::ChuckNorris.fact)
      end
    else
      i = 0   #this should be generalized to allow for more participants and randomized
      until i > self.map_size/2 + 1
        self.locations[i].update(controlled_by: player_array[1].id, content: Faker::StarWars.quote)
        i += 1
      end
    end
  end


end

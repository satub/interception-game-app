class Map < ApplicationRecord
  belongs_to :game
  has_many :locations


  def no_locations?
    self.locations.empty?
  end

  def assign_locations(player_array)  ##these should be team_ids, not player_ids
    number_of_locations = self.size_x.to_i * self.size_y.to_i
    if player_array.size == 1
      number_of_locations.times do
        location = Location.create(map_id: self.id, player_id: player_array[0].id, content: Faker::ChuckNorris.fact)
      end
    else
      i = 0   #this should be generalized to allow for more participants and randomized
      until i > number_of_locations/2 + 1
        self.locations[i].update(player_id: player_array[1].id, content: Faker::StarWars.quote)
        i += 1
      end
    end
  end

end

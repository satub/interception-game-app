class Map < ApplicationRecord
  belongs_to :game
  has_many :locations


  def no_locations?
    self.locations.empty?
  end

  def assign_locations
    number_of_locations = self.size_x.to_i * self.size_y.to_i
    number_of_locations.times do
      location = Location.create(map_id: self.id, content: Faker::ChuckNorris.fact)
    end
  end

end

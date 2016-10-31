class OrderedLocation < ApplicationRecord
  belongs_to :game
  has_many :character_locations
  has_many :characters, through: :character_locations

  self.table_name = 'ordered_locations'

  protected

  def readonly?
    true
  end
end

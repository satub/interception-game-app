class Scheme < ApplicationRecord
  belongs_to :turn
  belongs_to :location
  belongs_to :character, optional: true

end

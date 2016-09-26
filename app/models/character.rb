class Character < ApplicationRecord
  belongs_to :team
  enum role: [:leader, :ace, :elite]
end

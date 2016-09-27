class Character < ApplicationRecord
  belongs_to :team

  has_many :actions
  has_many :locations, through: :actions

  enum role: [:leader, :ace, :elite]
end

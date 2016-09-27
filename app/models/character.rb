class Character < ApplicationRecord
  belongs_to :team

  has_many :schemes
  has_many :locations, through: :schemes

  enum role: [:leader, :ace, :elite]
end

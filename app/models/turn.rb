class Turn < ApplicationRecord
  # belongs_to :team
  belongs_to :player #should be team
  has_many :actions
  has_many :locations, through: :actions
  has_many :characters, through: :actions

  accepts_nested_attributes_for :locations
  accepts_nested_attributes_for :actions
end

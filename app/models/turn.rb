class Turn < ApplicationRecord
  # belongs_to :team
  belongs_to :player #should be team
  has_many :actions
  has_many :locations, through: :actions
  has_many :characters, through: :actions

  accepts_nested_attributes_for :locations
  accepts_nested_attributes_for :actions


  ### By the way, Turn needs a status column for the intercepts to be implemented

  def actions_attributes=(action_attributes)
    # self.save
      binding.pry
    action_attributes.values.each do |action_attribute|
      action_attribute[:turn_id] = self.id
      action = Action.create(action_attribute)
      self.actions << action
    end
  end

  def locations_attributes=(location_attributes)
    self.locations.each do |location|
      location_attributes.values.each do |location_attribute|
        location.update(location_attribute)
      end
    end
  end

end

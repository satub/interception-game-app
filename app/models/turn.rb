class Turn < ApplicationRecord
  # belongs_to :team
  belongs_to :player #should be team
  has_many :schemes
  has_many :locations, through: :schemes
  has_many :characters, through: :schemes

  accepts_nested_attributes_for :locations
  accepts_nested_attributes_for :schemes


  ### By the way, Turn needs a status column for the intercepts to be implemented

  def schemes_attributes=(scheme_attributes)
    # self.save
      binding.pry
    scheme_attributes.values.each do |scheme_attribute|
      scheme_attribute[:turn_id] = self.id
      scheme = Scheme.create(scheme_attribute)
      self.schemes << scheme
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

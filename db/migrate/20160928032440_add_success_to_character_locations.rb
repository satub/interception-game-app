class AddSuccessToCharacterLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :character_locations, :success, :boolean
  end
end

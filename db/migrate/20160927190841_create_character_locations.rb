class CreateCharacterLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :character_locations do |t|
      t.integer :character_id
      t.integer :location_id
      t.integer :troops_sent
      t.string :message
      t.timestamps
    end
  end
end

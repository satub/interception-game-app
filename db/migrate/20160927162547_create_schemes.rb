class CreateSchemes < ActiveRecord::Migration[5.0]
  def change
    create_table :schemes do |t|
      t.string :nature
      t.integer :location_id
      t.integer :character_id
      t.integer :number_of_troops
      t.integer :turn_id
      t.timestamps
    end
  end
end

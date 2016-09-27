class CreateActions < ActiveRecord::Migration[5.0]
  def change
    create_table :actions do |t|
      t.string :action_type
      t.integer :location_id
      t.integer :character_id
      t.integer :number_of_troops
      t.timestamps
    end
  end
end

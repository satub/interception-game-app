class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.integer :controlled_by  #player_id
      t.integer :game_id
      t.string :content
      t.timestamps
    end
  end
end

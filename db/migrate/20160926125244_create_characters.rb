class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.integer :player_id
      t.string :name
      t.string :image_link
      t.string :personality
      t.integer :role, default: 0
      t.integer :level, default: 1
      t.timestamps
    end
  end
end

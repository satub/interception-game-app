class CreateGameCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :game_characters do |t|
      t.integer :game_id
      t.integer :character_id
      t.integer :troops, default: 1000

      t.timestamps
    end
  end
end

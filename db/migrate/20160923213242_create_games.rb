class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :title
      t.string :status, default: "pending"  #other options: "over", "active", "forfeit"
      t.integer :turn #player_id
      t.integer :winner  #player_id
      t.string :map_name
      t.integer :map_size
      t.string :map_style_link
      t.string :map_image_link
      t.string :background_image_link
      t.timestamps
    end
  end
end

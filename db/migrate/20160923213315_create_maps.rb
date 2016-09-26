class CreateMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :maps do |t|
      t.integer :game_id
      t.string :name
      t.string :style_link
      t.string :background_image_link
      t.integer :size_x
      t.integer :size_y
      t.timestamps
    end
  end
end

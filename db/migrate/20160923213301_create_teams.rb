class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.integer :player_id
      t.string :name
      t.string :motto
      t.integer :troops
      t.string :image_link
      t.string :style_link
      t.string :theme_link
      t.timestamps
    end
  end
end

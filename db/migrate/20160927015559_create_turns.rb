class CreateTurns < ActiveRecord::Migration[5.0]
  def change
    create_table :turns do |t|
      t.integer :team_id
      t.integer :player_id
      t.string :header
      t.timestamps
    end
  end
end

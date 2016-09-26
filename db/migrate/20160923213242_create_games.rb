class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :title
      t.string :fandom
      t.string :status
      t.integer :turn #team_id
      t.integer :winner  #team_id
      t.timestamps
    end
  end
end

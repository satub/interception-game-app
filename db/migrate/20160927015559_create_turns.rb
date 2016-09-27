class CreateTurns < ActiveRecord::Migration[5.0]
  def change
    create_table :turns do |t|

      t.timestamps
    end
  end
end

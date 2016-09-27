class AddPlayerIdToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :player_id, :integer
  end
end

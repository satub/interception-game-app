class AddTurnIdToAction < ActiveRecord::Migration[5.0]
  def change
    add_column :actions, :turn_id, :integer
  end
end

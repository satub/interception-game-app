class AddDefenseToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :defense, :integer
  end
end

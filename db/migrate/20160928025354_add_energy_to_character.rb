class AddEnergyToCharacter < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :energy, :integer, default: 1000
  end
end

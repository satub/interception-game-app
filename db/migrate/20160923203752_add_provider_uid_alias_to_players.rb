class AddProviderUidAliasToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :uid, :string
    add_column :players, :provider, :string
    add_column :players, :alias, :string 
  end
end

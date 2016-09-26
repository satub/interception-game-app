class AddTeamIdToCharacter < ActiveRecord::Migration[5.0]
  def change
      add_column :characters, :team_id, :integer
  end
end

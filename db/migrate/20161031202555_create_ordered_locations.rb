class CreateOrderedLocations < ActiveRecord::Migration[5.0]
  def up
    self.connection.execute %Q( CREATE OR REPLACE VIEW ordered_locations AS
        SELECT
            id,
            content,
            defense,
            controlled_by,
            game_id
          FROM locations
          ORDER BY id ASC;
        )
  end

  def down
    self.connection.execute "DROP VIEW IF EXISTS ordered_locations;"
  end

end

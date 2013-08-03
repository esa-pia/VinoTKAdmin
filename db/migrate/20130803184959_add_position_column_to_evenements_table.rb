class AddPositionColumnToEvenementsTable < ActiveRecord::Migration
  def up
    add_column :evenements, :position, :int
  end

  def down
    remove_column :evenements, :position
  end
end

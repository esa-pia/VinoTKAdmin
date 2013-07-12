class RemoveColumnsToBouteuillesCataloguesTable < ActiveRecord::Migration
  def up
  	remove_column :bouteilles_catalogues, :created_at, :created_at
    remove_column :bouteilles_catalogues, :updated_at, :updated_at
  end

  def down
    add_column :bouteilles_catalogues, :created_at, :datetime
    add_column :bouteilles_catalogues, :updated_at, :datetime
  end
end

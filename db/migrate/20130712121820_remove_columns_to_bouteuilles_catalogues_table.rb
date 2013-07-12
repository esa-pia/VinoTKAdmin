class RemoveColumnsToBouteuillesCataloguesTable < ActiveRecord::Migration
  def up
  	remove_column :bouteilles_catalogues, :created_at, :timestamps
    remove_column :bouteilles_catalogues, :updated_at, :timestamps
  end

  def down
    add_column :bouteilles_catalogues, :created_at, :datetime
    add_column :bouteilles_catalogues, :updated_at, :datetime
  end
end

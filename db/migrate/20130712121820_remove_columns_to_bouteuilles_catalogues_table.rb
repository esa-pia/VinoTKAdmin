class RemoveColumnsToBouteuillesCataloguesTable < ActiveRecord::Migration
  def up
  	#remove_column :bouteilles_catalogues, :created_at, :datetime
    #remove_column :bouteilles_catalogues, :updated_at, :datetime
  end

  def down
    add_column :bouteilles_catalogues, :created_at, :datetime
    add_column :bouteilles_catalogues, :updated_at, :datetime
  end
end

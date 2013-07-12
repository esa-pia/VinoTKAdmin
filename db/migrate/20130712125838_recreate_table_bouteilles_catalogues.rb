class RecreateTableBouteillesCatalogues < ActiveRecord::Migration
  def up
    remove_index :bouteilles_catalogues, :bouteille_id
    remove_index :bouteilles_catalogues, :catalogue_id
    
    drop_table :bouteilles_catalogues
  	
  	create_table :bouteilles_catalogues do |t|
      t.references :bouteille
      t.references :catalogue
    end
    
    add_index :bouteilles_catalogues, :bouteille_id
    add_index :bouteilles_catalogues, :catalogue_id
  end

  def down
  end
end

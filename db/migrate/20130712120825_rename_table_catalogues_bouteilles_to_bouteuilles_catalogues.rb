class RenameTableCataloguesBouteillesToBouteuillesCatalogues < ActiveRecord::Migration
  def self.up
    remove_index :catalogues_bouteilles, :bouteille_id
    remove_index :catalogues_bouteilles, :catalogue_id
    
    rename_table :catalogues_bouteilles, :bouteilles_catalogues

    add_index :bouteilles_catalogues, :bouteille_id
    add_index :bouteilles_catalogues, :catalogue_id
  end

 def self.down
 	remove_index :bouteilles_catalogues, :bouteille_id
    remove_index :bouteilles_catalogues, :catalogue_id

    rename_table :bouteilles_catalogues, :catalogues_bouteilles

    add_index :catalogues_bouteilles, :bouteille_id
    add_index :catalogues_bouteilles, :catalogue_id
 end
end
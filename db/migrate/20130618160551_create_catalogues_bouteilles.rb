class CreateCataloguesBouteilles < ActiveRecord::Migration
  def change
    create_table :catalogues_bouteilles do |t|
      t.references :bouteille
      t.references :catalogue

      t.timestamps
    end
    add_index :catalogues_bouteilles, :bouteille_id
    add_index :catalogues_bouteilles, :catalogue_id
  end
end

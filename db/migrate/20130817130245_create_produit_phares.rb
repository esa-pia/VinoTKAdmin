class CreateProduitPhares < ActiveRecord::Migration
  def change
    create_table :produit_phares do |t|
      t.references :bouteille
      t.decimal :rabais
      t.text :description
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end
    add_index :produit_phares, :bouteille_id
  end
end

class CreateEvenements < ActiveRecord::Migration
  def change
    create_table :evenements do |t|
      t.string :titre
      t.string :description
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.datetime :date_debut
      t.datetime :date_fin
      t.references :newsletter

      t.timestamps
    end
    add_index :evenements, :newsletter_id
  end
end

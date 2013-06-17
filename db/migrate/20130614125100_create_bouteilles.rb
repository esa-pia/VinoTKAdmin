class CreateBouteilles < ActiveRecord::Migration
  def change
    create_table :bouteilles do |t|
      t.string :appellation
      t.references :type
      t.text :description
      t.references :cuvee
      t.references :domaine
      t.references :format
      t.references :millesime
      t.decimal :prix
      t.boolean :nouveau

      t.timestamps
    end
    add_index :bouteilles, :type_id
    add_index :bouteilles, :cuvee_id
    add_index :bouteilles, :domaine_id
    add_index :bouteilles, :format_id
    add_index :bouteilles, :millesime_id
  end
end

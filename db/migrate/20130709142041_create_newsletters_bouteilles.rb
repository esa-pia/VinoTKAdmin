class CreateNewslettersBouteilles < ActiveRecord::Migration
  def change
    create_table :newsletters_bouteilles do |t|
      t.references :newsletter
      t.references :bouteille
      t.decimal :rabais

      t.timestamps
    end
    add_index :newsletters_bouteilles, :newsletter_id
    add_index :newsletters_bouteilles, :bouteille_id
  end
end

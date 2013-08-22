class AddProduitPhareToNewsletter < ActiveRecord::Migration
  def up
    add_column :produit_phares, :newsletter_id, :int
    add_index  :produit_phares, :newsletter_id
  end

  def down
    remove_column :produit_phares, :newsletter_id
    remove_index  :produit_phares, :newsletter_id
  end
end

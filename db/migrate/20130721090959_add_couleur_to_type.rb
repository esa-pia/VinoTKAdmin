class AddCouleurToType < ActiveRecord::Migration
  def self.up
    add_column :types, :couleur,             :string
  end
 
  def self.down
    remove_column :types, :couleur
  end
end

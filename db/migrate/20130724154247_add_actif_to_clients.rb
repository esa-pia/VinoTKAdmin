class AddActifToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :actif, :boolean
  end
 
  def self.down
    remove_column :clients, :actif
  end
end

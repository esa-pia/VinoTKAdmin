class RenameActifToInactifToClients < ActiveRecord::Migration
  def up
  	rename_column :clients, :actif, :inactif
  end

  def down
  	rename_column :clients, :inactif, :actif
  end
end

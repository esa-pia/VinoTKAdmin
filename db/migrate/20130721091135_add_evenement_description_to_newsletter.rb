class AddEvenementDescriptionToNewsletter < ActiveRecord::Migration
  def self.up
    add_column :newsletters, :evenement_description,             :text
  end
 
  def self.down
    remove_column :newsletters, :evenement_description
  end
end

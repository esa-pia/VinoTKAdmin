class AddFieldsToNewsletter < ActiveRecord::Migration
  def self.up
    add_column :newsletters, :evenement_image_file_name,    :string
    add_column :newsletters, :evenement_image_content_type, :string
    add_column :newsletters, :evenement_image_file_size,    :integer
    add_column :newsletters, :evenement_image_updated_at,   :datetime
    add_column :newsletters, :promotions_titre,             :string
    add_column :newsletters, :info_description,             :text
    add_column :newsletters, :statut,                       :string
  end
 
  def self.down
    remove_column :newsletters, :evenement_image_file_name
    remove_column :newsletters, :evenement_image_content_type
    remove_column :newsletters, :evenement_image_file_size
    remove_column :newsletters, :evenement_image_updated_at
    remove_column :newsletters, :promotions_titre
    remove_column :newsletters, :info_description
    remove_column :newsletters, :statut
  end
end

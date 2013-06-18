class AddImagesToCatalogue < ActiveRecord::Migration
  def self.up
    add_column :catalogues, :image1, :string
    add_column :catalogues, :image2, :string
    add_column :catalogues, :image3, :string
    add_column :catalogues, :image4, :string
    add_column :catalogues, :image5, :string
    add_column :catalogues, :image6, :string
  end

  def self.down
    remove_column :catalogues, :image1
    remove_column :catalogues, :image2
    remove_column :catalogues, :image3
    remove_column :catalogues, :image4
    remove_column :catalogues, :image5
    remove_column :catalogues, :image6
  end
end

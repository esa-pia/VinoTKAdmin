class AddUpdateImagesToCatalogue < ActiveRecord::Migration
   def self.up
    add_column :catalogues, :image1_file_name,    :string
    add_column :catalogues, :image1_content_type, :string
    add_column :catalogues, :image1_file_size,    :integer
    add_column :catalogues, :image1_updated_at,   :datetime
    
    add_column :catalogues, :image2_file_name,    :string
    add_column :catalogues, :image2_content_type, :string
    add_column :catalogues, :image2_file_size,    :integer
    add_column :catalogues, :image2_updated_at,   :datetime
    
    add_column :catalogues, :image3_file_name,    :string
    add_column :catalogues, :image3_content_type, :string
    add_column :catalogues, :image3_file_size,    :integer
    add_column :catalogues, :image3_updated_at,   :datetime
    
    add_column :catalogues, :image4_file_name,    :string
    add_column :catalogues, :image4_content_type, :string
    add_column :catalogues, :image4_file_size,    :integer
    add_column :catalogues, :image4_updated_at,   :datetime
    
    add_column :catalogues, :image5_file_name,    :string
    add_column :catalogues, :image5_content_type, :string
    add_column :catalogues, :image5_file_size,    :integer
    add_column :catalogues, :image5_updated_at,   :datetime
    
    add_column :catalogues, :image6_file_name,    :string
    add_column :catalogues, :image6_content_type, :string
    add_column :catalogues, :image6_file_size,    :integer
    add_column :catalogues, :image6_updated_at,   :datetime
    
    remove_column :catalogues, :image1
    remove_column :catalogues, :image2
    remove_column :catalogues, :image3
    remove_column :catalogues, :image4
    remove_column :catalogues, :image5
    remove_column :catalogues, :image6
  end
 
  def self.down
    add_column :catalogues, :image1, :string
    add_column :catalogues, :image2, :string
    add_column :catalogues, :image3, :string
    add_column :catalogues, :image4, :string
    add_column :catalogues, :image5, :string
    add_column :catalogues, :image6, :string
    
    remove_column :catalogues, :image1_file_name
    remove_column :catalogues, :image1_content_type
    remove_column :catalogues, :image1_file_size
    remove_column :catalogues, :image1_updated_at
    
    remove_column :catalogues, :image2_file_name
    remove_column :catalogues, :image2_content_type
    remove_column :catalogues, :image2_file_size
    remove_column :catalogues, :image2_updated_at
    
    remove_column :catalogues, :image3_file_name
    remove_column :catalogues, :image3_content_type
    remove_column :catalogues, :image3_file_size
    remove_column :catalogues, :image3_updated_at

    remove_column :catalogues, :image4_file_name
    remove_column :catalogues, :image4_content_type
    remove_column :catalogues, :image4_file_size
    remove_column :catalogues, :image4_updated_at

    remove_column :catalogues, :image5_file_name
    remove_column :catalogues, :image5_content_type
    remove_column :catalogues, :image5_file_size
    remove_column :catalogues, :image5_updated_at
    
    remove_column :catalogues, :image5_file_name
    remove_column :catalogues, :image5_content_type
    remove_column :catalogues, :image5_file_size
    remove_column :catalogues, :image5_updated_at



  end
end

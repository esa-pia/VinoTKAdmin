class ProduitPhare < ActiveRecord::Base
  belongs_to :bouteille
  attr_accessible :description, :image_content_type, :image_file_name, :image_file_size, :image_updated_at, :rabais
end

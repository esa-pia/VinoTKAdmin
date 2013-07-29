class Evenement < ActiveRecord::Base
  belongs_to :newsletter
  attr_accessible :date_debut, :date_fin, :description, :image_content_type, :image_file_name, :image_file_size, :image_updated_at, :titre
end

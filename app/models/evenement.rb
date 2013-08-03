#require 'file_attacher'
class Evenement < ActiveRecord::Base
  just_define_datetime_picker :date_debut, :add_to_attr_accessible => true
  just_define_datetime_picker :date_fin, :add_to_attr_accessible => true

  has_attached_file :image, :styles => {:medium => "400", :thumb => "60"}

  attr_accessible :image
  belongs_to :newsletter
  attr_accessible :date_debut, :date_fin, :description, :titre, :position
end

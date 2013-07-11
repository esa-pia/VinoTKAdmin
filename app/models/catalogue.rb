#require 'file_attacher'

class Catalogue < ActiveRecord::Base
  attr_accessible :titre, :bouteille_ids, :image1, :image2, :image3, :image4, :image5, :image6
  has_many :catalogues_bouteilles
  has_many :bouteilles , :through => :catalogues_bouteilles

  has_attached_file :image1, :styles => {:medium => "238x238>", :thumb => "60x60>"}

  has_attached_file :image2, :styles => {:medium => "238x238>", :thumb => "60x60>"}

  has_attached_file :image3, :styles => {:medium => "238x238>", :thumb => "60x60>"}

  has_attached_file :image4, :styles => {:medium => "238x238>", :thumb => "60x60>"}

  has_attached_file :image5, :styles => {:medium => "238x238>", :thumb => "60x60>"}

  has_attached_file :image6, :styles => {:medium => "238x238>", :thumb => "60x60>"}

  validates :titre, :presence => true
  validates :bouteilles, :presence => true


  def display_name
    titre
  end
  search_methods :bouteille_ids_eq

  scope :bouteille_ids_eq, lambda { |bouteille_id|
    Catalogue.joins(:bouteilles).where("bouteille_id = ?", bouteille_id)
  }
  def catalogue_location
    "#{Rails.root}/pdfs/catalogue-#{self.id}.pdf"
  end
end

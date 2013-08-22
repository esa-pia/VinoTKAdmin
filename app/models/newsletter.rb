class Newsletter < ActiveRecord::Base
  
  attr_accessible :titre, :description, :statut

  attr_accessible :promotions_titre
  
  has_many :produit_phares
  accepts_nested_attributes_for :produit_phares, :allow_destroy => true
  attr_accessible :produit_phares_attributes, :produit_phares

  has_many :newsletters_bouteilles, :dependent => :destroy, :order => 'newsletters_bouteilles.position ASC'
  accepts_nested_attributes_for :newsletters_bouteilles, :allow_destroy => true
  attr_accessible :newsletters_bouteilles_attributes
 
  
  has_many :evenements, :dependent => :destroy, :order => 'evenements.position ASC'
  accepts_nested_attributes_for :evenements, :allow_destroy => true
  attr_accessible :evenements_attributes

  
  attr_accessible :info, :info_description

  validates :titre, :presence => true
  def display_name
    titre
  end
end

class Newsletter < ActiveRecord::Base
  has_many :newsletters_bouteilles, :dependent => :destroy, :order => 'newsletters_bouteilles.position ASC'
  accepts_nested_attributes_for :newsletters_bouteilles, :allow_destroy => true

  attr_accessible :info, :titre
  attr_accessible :description, :newsletters_bouteilles_attributes
 
  has_many :evenements, :dependent => :destroy
  accepts_nested_attributes_for :evenements, :allow_destroy => true
  attr_accessible :evenements_attributes

  attr_accessible :promotions_titre
  attr_accessible :info_description
  attr_accessible :statut


  validates :titre, :presence => true
  def display_name
    titre
  end
end

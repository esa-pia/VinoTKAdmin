#require 'file_attacher'
class Newsletter < ActiveRecord::Base
  just_define_datetime_picker :date_debut, :add_to_attr_accessible => true
  just_define_datetime_picker :date_fin, :add_to_attr_accessible => true
  
  has_many :newsletters_bouteilles, :dependent => :destroy, :order => 'newsletters_bouteilles.position ASC'
  accepts_nested_attributes_for :newsletters_bouteilles, :allow_destroy => true

  attr_accessible :info, :titre, :titre_evenement, :description, :newsletters_bouteilles_attributes
 
  has_attached_file :evenement_image, :styles => {:medium => "400", :thumb => "60"}

  attr_accessible :evenement_image
  attr_accessible :evenement_description
  attr_accessible :promotions_titre
  attr_accessible :info_description
  attr_accessible :statut


  validates :titre, :presence => true
  def display_name
    titre
  end

  def date_debut_date
    if(date_debut)
      date_debut.strftime("%d-%m-%Y")
    else
      ""
    end
  end
  def date_fin_date
    if(date_fin)
      date_fin.strftime("%d-%m-%Y")
    else
      ""
    end
  end
end

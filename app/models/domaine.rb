class Domaine < ActiveRecord::Base
  attr_accessible :libelle

  validates :libelle, :presence => true


  def display_name
    libelle
  end
  
end

class Type < ActiveRecord::Base
  attr_accessible :libelle
  has_many :bouteilles
  
  def display_name
    libelle
  end
   
end

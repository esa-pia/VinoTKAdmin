class Type < ActiveRecord::Base
  attr_accessible :libelle
  
  
  def display_name
    libelle
  end
   
end

class Format < ActiveRecord::Base
  attr_accessible :valeur

  validates :valeur, :presence => true


  def display_name
    valeur
  end
  
end

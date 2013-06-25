class Format < ActiveRecord::Base
  attr_accessible :valeur

  validates :valeur, :presence => true , :uniqueness => true


  def display_name
    valeur
  end
  
end

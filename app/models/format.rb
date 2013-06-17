class Format < ActiveRecord::Base
  attr_accessible :valeur

  def display_name
    valeur
  end
  
end

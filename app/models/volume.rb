class Volume < ActiveRecord::Base
  attr_accessible :valeur, :bouteille_ids
  has_many :bouteilles

  validates :valeur, :presence => true , :uniqueness => true


  def display_name
    valeur
  end
end

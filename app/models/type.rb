class Type < ActiveRecord::Base
  attr_accessible :libelle
  has_many :bouteilles

  validates :libelle, :presence => true

  def display_name
    libelle
  end
   
end

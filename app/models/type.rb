class Type < ActiveRecord::Base
  attr_accessible :libelle, :bouteille_ids, :couleur
  has_many :bouteilles
  validates :couleur, presence: true, length: { in: 3..7 }
  validates :libelle, :presence => true , :uniqueness => true

  def display_name
    libelle
  end
   
end

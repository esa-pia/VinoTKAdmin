class Cuvee < ActiveRecord::Base
  attr_accessible :libelle, :bouteille_ids
  has_many :bouteilles

  validates :libelle, :presence => true, :uniqueness => true

  def display_name
    libelle
  end
end

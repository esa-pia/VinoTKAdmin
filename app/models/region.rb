class Region < ActiveRecord::Base
  attr_accessible :libelle

  validates :libelle, :presence => true, :uniqueness => true

  def display_name
    libelle
  end
end

class NewslettersBouteille < ActiveRecord::Base
  belongs_to :newsletter
  belongs_to :bouteille

  attr_accessible :rabais, :position
  attr_accessible :bouteille_id, :newsletter_id
  
  #validates :newsletter, :presence => true
  validates :bouteille, :presence => true

  #validates_uniqueness_of :bouteille_id, :scope => :newsletter_id

  def nouveau_prix
    nouveau_prix = bouteille.prix
    nouveau_prix = nouveau_prix * (1 - (rabais/100)) if rabais?
  end
end

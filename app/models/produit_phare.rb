#require 'file_attacher'
class ProduitPhare < ActiveRecord::Base
  belongs_to :newsletter
  belongs_to :bouteille
  
  has_attached_file :image, :styles => {:medium => "350", :thumb => "60"}
  attr_accessible :image
  
  belongs_to :newsletter
  
  attr_accessible :description, :rabais
  attr_accessible :bouteille_id, :newsletter_id
  validates :bouteille, :presence => true

  def nouveau_prix
    nouveau_prix = 0
    if(!bouteille.nil?)
      nouveau_prix = bouteille.prix
      nouveau_prix = nouveau_prix * (1 - (rabais/100)) if rabais?
    end
    ActionController::Base.helpers.number_to_currency(nouveau_prix, unit: "", separator: ".", delimiter: "", format: "%n")
  end
  def prix
    prix = 0
    if(!bouteille.nil?)
      prix = bouteille.prix
    end
    ActionController::Base.helpers.number_to_currency(prix, unit: "", separator: ".", delimiter: "", format: "%n")
  end
end

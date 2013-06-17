class Bouteille < ActiveRecord::Base
  belongs_to :type
  belongs_to :cuvee
  belongs_to :domaine
  belongs_to :format
  belongs_to :millesime
  attr_accessible :type_id, :domaine_id, :cuvee_id, :format_id, :millesime_id, :appellation, :description, :nouveau, :prix
  
  
  
  
  
  def display_name
    appellation
  end
end

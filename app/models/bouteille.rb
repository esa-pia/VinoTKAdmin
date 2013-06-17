class Bouteille < ActiveRecord::Base
  belongs_to :type
  belongs_to :cuvee
  belongs_to :domaine
  belongs_to :format
  belongs_to :millesime
  attr_accessible :type_id, :domaine_id, :cuvee_id, :format_id, :millesime_id, :appellation, :description, :nouveau, :prix
  
  scope :rouge, where(:type_id => Type.where(:libelle => 'Rouge'))
  scope :blanc, where(:type_id => Type.where(:libelle => 'Blanc'))
  scope :rose, where(:type_id => Type.where("libelle like ?",'%Ros%'))
  scope :effervescent, where(:type_id => Type.where(:libelle => 'Effervescent'))
  scope :alcool_digestif, where(:type_id => Type.where(:libelle => 'Alcool / Digestif'))
  scope :aperitif, where(:type_id => Type.where("libelle like ?",'%Ap%'))
  scope :whisky, where(:type_id => Type.where(:libelle => 'Whisky'))
  
  
  def display_name
    appellation
  end
end

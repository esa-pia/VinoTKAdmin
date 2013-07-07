class Bouteille < ActiveRecord::Base
  belongs_to :type
  belongs_to :cuvee
  belongs_to :region
  belongs_to :domaine
  belongs_to :volume
  belongs_to :millesime
  attr_accessible :type_id, :domaine_id, :cuvee_id, :region_id, :volume_id, :millesime_id, :appellation, :description, :nouveau, :prix


  validates :appellation, :presence => true
  validates :type, :presence => true
  validates :cuvee, :presence => true
  validates :region, :presence => true
  validates :domaine, :presence => true
  validates :volume, :presence => true
  validates :millesime, :presence => true
  validates :prix, :presence => true



  scope :rouge, where(:type_id => Type.where(:libelle => 'Rouge'))
  scope :blanc, where(:type_id => Type.where(:libelle => 'Blanc'))
  scope :rose, where(:type_id => Type.where("libelle like ?",'%Ros%'))
  scope :effervescent, where(:type_id => Type.where(:libelle => 'Effervescent'))
  scope :alcool_digestif, where(:type_id => Type.where("libelle like ? or libelle like ? ",'%Alcool%', '%Digestif%'))
  scope :aperitif, where(:type_id => Type.where("libelle like ?",'%Ap%'))
  scope :whisky, where(:type_id => Type.where(:libelle => 'Whisky'))
  
  
  def display_name
    appellation
  end
  def type_libelle
    type.libelle
  end
  
  def bouteille_location
    "#{Rails.root}/pdfs/bouteille-#{self.id}.pdf"
  end
  
  
  def as_json(options={})
    super(
      :only => [:id, :appellation, :description, :prix,:nouveau],
      :include => { type: { only: [:libelle] },domaine: { only: [:libelle] },cuvee: { only: [:libelle] },region: { only: [:libelle] },volume: { only: [:valeur] },millesime: { only: [:valeur] }}
    )
  end
end

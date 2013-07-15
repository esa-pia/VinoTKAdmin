class Bouteille < ActiveRecord::Base
  belongs_to :type
  belongs_to :cuvee
  belongs_to :region
  belongs_to :domaine
  belongs_to :volume
  belongs_to :millesime
  attr_accessible :type_id, :domaine_id, :cuvee_id, :region_id, :volume_id, :millesime_id, :appellation, :description, :nouveau, :prix
  has_and_belongs_to_many  :catalogues

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

  search_methods :domaine_in_eq
  search_methods :cuvee_in_eq
  search_methods :volume_in_eq
  search_methods :millesime_in_eq
  search_methods :region_in_eq
  
  scope :domaine_in_eq, lambda { |domaine_ids|
    Bouteille.where("domaine_id in (?)", domaine_ids)
  }
  scope :cuvee_in_eq, lambda { |cuvee_ids|
    Bouteille.where("cuvee_id in (?)", cuvee_ids)
  }
  scope :volume_in_eq, lambda { |volume_ids|
    Bouteille.where("volume_id in (?)", volume_ids)
  }
  scope :millesime_in_eq, lambda { |millesime_ids|
    Bouteille.where("millesime_id in (?)", millesime_ids)
  }
  scope :region_in_eq, lambda { |region_ids|
    Bouteille.where("region_id in (?)", region_ids)
  }
end

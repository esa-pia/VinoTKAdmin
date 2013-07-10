class Newsletter < ActiveRecord::Base
  just_define_datetime_picker :date_debut, :add_to_attr_accessible => true
  just_define_datetime_picker :date_fin, :add_to_attr_accessible => true
  
  #has_many :newsletters_bouteilles
  #has_many :bouteilles_rabais , :through => :newsletters_bouteilles , :dependent => :destroy, 
  #          :class_name => 'NewslettersBouteille', :source => :newsletter
  #accepts_nested_attributes_for :bouteilles_rabais, :allow_destroy => true

  has_many :newsletters_bouteilles, :dependent => :destroy
  
  accepts_nested_attributes_for :newsletters_bouteilles, :allow_destroy => true




  attr_accessible :info, :titre, :description, :newsletters_bouteilles_attributes

  validates :titre, :presence => true
  def display_name
    titre
  end

  def date_debut_date
    date_debut.strftime("%d-%m-%Y")
  end
  def date_fin_date
    date_fin.strftime("%d-%m-%Y")
  end
end

class Newsletter < ActiveRecord::Base
  just_define_datetime_picker :date_debut, :add_to_attr_accessible => true
  just_define_datetime_picker :date_fin, :add_to_attr_accessible => true
  
  has_many :newsletters_bouteilles, :dependent => :destroy
  accepts_nested_attributes_for :newsletters_bouteilles, :allow_destroy => true

  attr_accessible :info, :titre, :description, :newsletters_bouteilles_attributes

  validates :titre, :presence => true
  def display_name
    titre
  end

  def date_debut_date
    if(date_debut)
      date_debut.strftime("%d-%m-%Y")
    else
      ""
    end
  end
  def date_fin_date
    if(date_fin)
      date_fin.strftime("%d-%m-%Y")
    else
      ""
    end
  end
end

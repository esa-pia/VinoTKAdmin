class Newsletter < ActiveRecord::Base
  just_define_datetime_picker :date_debut, :add_to_attr_accessible => true
  just_define_datetime_picker :date_fin, :add_to_attr_accessible => true

  attr_accessible :info, :titre

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

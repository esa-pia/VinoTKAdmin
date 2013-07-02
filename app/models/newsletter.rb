class Newsletter < ActiveRecord::Base
  just_define_datetime_picker :date_debut, :add_to_attr_accessible => true
  just_define_datetime_picker :date_fin, :add_to_attr_accessible => true

  attr_accessible :info, :titre

  validates :titre, :presence => true
  def display_name
    titre
  end
end

class Newsletter < ActiveRecord::Base
  attr_accessible :date_debut, :date_fin, :info, :titre

  validates :titre, :presence => true
  def display_name
    titre
  end
end

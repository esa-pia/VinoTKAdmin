class CataloguesBouteille < ActiveRecord::Base
  belongs_to :bouteille
  belongs_to :catalogue
  attr_accessible :bouteille_id, :catalogue_id
end

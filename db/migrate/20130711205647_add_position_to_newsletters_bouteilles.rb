class AddPositionToNewslettersBouteilles < ActiveRecord::Migration
  def change
    add_column :newsletters_bouteilles, :position, :int
  end
end

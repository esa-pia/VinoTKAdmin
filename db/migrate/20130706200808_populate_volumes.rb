class PopulateVolumes < ActiveRecord::Migration
  def up
  	Volume.delete_all
  	formats = Format.find(:all)
    formats.each do |format|
      Volume.create([{ valeur: format.valeur }])
    end
  end

  def down
  end
end
class MigrateColumnFormatToColumnVolumeInTableBouteille < ActiveRecord::Migration
 def up
  	formats = Format.find(:all)
    formats.each do |format|
      say "format #{format.valeur}"
      volume = Volume.where(:valeur => format.valeur).first
      if(volume)
        say "volume #{volume.id}"
        bouteilles = Bouteille.where("format_id = #{format.id}").find(:all)
        if(bouteilles && bouteilles.count>0)
          bouteilles.each do |bouteille|
            say "update bouteille"
            say "UPDATE bouteilles SET volume_id = #{volume.id} WHERE id = #{bouteille.id} "
            execute "UPDATE bouteilles SET volume_id = #{volume.id} WHERE id = #{bouteille.id} "
          end
        end
      end
    end
  end

  def down
  end
end
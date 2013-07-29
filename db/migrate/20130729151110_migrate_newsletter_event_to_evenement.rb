class MigrateNewsletterEventToEvenement < ActiveRecord::Migration
  def up
  	newsletters = Newsletter.find(:all)
    newsletters.each do |newsletter|
      say "newsletters #{newsletter.id}"
      evenement   = Evenement.create([
      	            { 
      	            	titre: newsletter.titre_evenement,
                        description: newsletter.evenement_description,
                        image_file_name: newsletter.evenement_image_file_name,
                        image_content_type: newsletter.evenement_image_content_type,
                        image_file_size: newsletter.evenement_image_file_size,
                        image_updated_at: newsletter.evenement_image_updated_at,
                        date_debut: newsletter.date_debut,
                        date_fin: newsletter.date_fin
      	            }
      	            ]);
      newsletter.evenements << evenement
      newsletter.save();
    end
  end

  def down
  end
end
